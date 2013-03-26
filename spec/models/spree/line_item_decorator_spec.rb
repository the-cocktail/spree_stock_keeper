require 'spec_helper'

describe Spree::LineItem do
  let!(:variant) { 
    Spree::Config[:track_inventory_levels] = true
    create(:variant)
  }
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
      create(:line_item, :variant => variant, :quantity => 5, :stock_keeper_expires_at => 1.day.ago)
      Spree::LineItem.stock_keepings_for(variant).should == 5
    end
    it "should ignore another variant's line items" do
      create(:line_item_with_stock_keeped, :quantity => 5, :variant => variant)
      create(:line_item_with_stock_keeped, :quantity => 5, :variant => create(:variant))
      Spree::LineItem.stock_keepings_for(variant).should == 5
    end
  end
end
