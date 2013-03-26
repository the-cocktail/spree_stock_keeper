unless Spree::Variant.instance_methods.include? :on_hand_without_stock_keeper
  Spree::Variant.class_eval do
    alias_method :on_hand_without_stock_keeper, :on_hand
    def on_hand
      on_hand_without_stock_keeper - Spree::LineItem.stock_keepings_for(self)
    end
  end
end
