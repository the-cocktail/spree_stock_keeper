require 'spec_helper'

describe Spree::Variant do
      
  let!(:variant) { 
    Spree::Config[:track_inventory_levels] = true
    create(:variant, :count_on_hand => 95)
  }

  before(:each) do
    reset_spree_preferences
  end

  context "on_hand" do
    # Without order/line items (original Spree specs)
    context "when :track_inventory_levels is true" do
      it "should return count_on_hand" do
        variant.on_hand.should == variant.count_on_hand
      end
    end

    context "when :track_inventory_levels is false" do
      before { Spree::Config.set :track_inventory_levels => false }

      it "should return nil" do
        variant.on_hand.should eql(1.0/0) # Infinity
      end
    end

    # With order/line items
    context "when included within an order" do
      it "should return count_on_hand less current line items quantities" do
        variant.count_on_hand = 50
        Spree::LineItem.should_receive(:stock_keepings_for).with(variant).and_return(5)
        variant.on_hand.should == 45
      end
    end

  end

  context "in_stock?" do
    # Without order/line items (original Spree specs)
    context "when :track_inventory_levels is true" do
      it "should be true when count_on_hand is positive" do
        variant.in_stock?.should be_true
      end

      it "should be false when count_on_hand is zero" do
        variant.stub(:count_on_hand => 0)
        variant.in_stock?.should be_false
      end

      it "should be false when count_on_hand is negative" do
        variant.stub(:count_on_hand => -10)
        variant.in_stock?.should be_false
      end
    end

    context "when :track_inventory_levels is false" do
      before { Spree::Config.set :track_inventory_levels => false }

      it "should be true" do
        variant.in_stock?.should be_true
      end
    end
  end
end
