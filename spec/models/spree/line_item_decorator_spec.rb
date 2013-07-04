require 'spec_helper'

describe Spree::LineItem do
  let!(:variant) { 
    Spree::Config[:track_inventory_levels] = true
    create(:variant)
  }
  context '#stock_keeper_expires_at' do
    let(:order) {create(:order)}
    let(:line_item) {create(:line_item)}
    it "should be taken from order if order's expiration has already been set" do
      expires_at = 10.minutes.from_now
      order.update_attribute(:stock_keeper_expires_at, expires_at)
      order.line_items << line_item
      line_item.stock_keeper_expires_at.to_s.should eql expires_at.to_s
    end
    it "should be set to config's expiration minutes if order's expiration has not been set yet" do
      expires_at = 1.hours.from_now
      Spree::StockKeeper.stub(:expires_at).and_return(expires_at)
      order.line_items << line_item
      line_item.stock_keeper_expires_at.should eq expires_at
      line_item.order.stock_keeper_expires_at.should eq expires_at
    end
    it "should be set to config's expiration minutes if order's expiration is later than that config value" do
      config_expires_at = 1.hours.from_now
      order_expires_at = 2.hours.from_now
      Spree::StockKeeper.stub(:expires_at).and_return(config_expires_at)
      order.update_attribute(:stock_keeper_expires_at, order_expires_at)
      order.line_items << line_item
      line_item.stock_keeper_expires_at.to_s.should eq config_expires_at.to_s
      line_item.order.stock_keeper_expires_at.to_s.should eq config_expires_at.to_s
    end
    it "should keep its own expiration time and copy to its order if its sooner than order's expiration" do
      expires_at = 30.minutes.from_now
      config_expires_at = 1.hours.from_now
      order_expires_at = 2.hours.from_now
      line_item.stock_keeper_expires_at = expires_at
      Spree::StockKeeper.stub(:expires_at).and_return(config_expires_at)
      order.update_attribute(:stock_keeper_expires_at, order_expires_at)
      order.line_items << line_item
      line_item.stock_keeper_expires_at.to_s.should eq expires_at.to_s
      line_item.order.stock_keeper_expires_at.to_s.should eq expires_at.to_s
    end
  end
  context '.stock_keepings_for variant (class method)' do
    it "should return zero if there's no line items" do
      Spree::LineItem.stock_keepings_for(variant).should == 0
    end
    it "should return the sum of the amounts of the line items" do
      create(:line_item_with_stock_keeped, :quantity => 5, :variant => variant)
      create(:line_item_with_stock_keeped, :quantity => 5, :variant => variant)
      Spree::LineItem.stock_keepings_for(variant).should == 10
    end
    it "should ignore expired line items" do
      create(:line_item_with_stock_keeped, :variant => variant, :quantity => 5)
      expired = create(:line_item, :variant => variant, :quantity => 5)
      expired.update_column(:stock_keeper_expires_at, 1.second.ago)
      Spree::LineItem.stock_keepings_for(variant).should == 5
    end
    it "should ignore another variant's line items" do
      create(:line_item_with_stock_keeped, :quantity => 5, :variant => variant)
      create(:line_item_with_stock_keeped, :quantity => 5, :variant => create(:variant))
      Spree::LineItem.stock_keepings_for(variant).should == 5
    end
  end
end
