require 'spec_helper'

describe Spree::InventoryUnit do

  context "self.increase" do
    let(:line_item) { create(:line_item) }
    it "should create the inventory units even if on_hand is zero (cause stock_keeper )" do
      order = line_item.order
      variant = line_item.variant
      # Let's our unit be the only only one...
      variant.update_attribute(:count_on_hand, variant.count_on_hand - variant.on_hand)
      # and check it
      variant.on_hand.should be(0)
      Spree::InventoryUnit.should_receive(:create_units).with(order, variant, line_item.quantity, 0)
      Spree::InventoryUnit.increase(order, variant, line_item.quantity)
    end
  end
end
