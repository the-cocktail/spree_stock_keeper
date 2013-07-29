Spree::InventoryUnit.class_eval do
  private
    def self.determine_backorder(order, variant, quantity)
      # original code only uses on_hand that is used by the stock_keeper, so
      # let's use count_on_hand instead...
      if variant.count_on_hand == 0
        quantity
      elsif variant.count_on_hand.present? and variant.count_on_hand < quantity
        quantity - (variant.count_on_hand < 0 ? 0 : variant.count_on_hand)
      else
        0
      end
    end

end
