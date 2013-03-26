FactoryGirl.define do
  factory :line_item_with_stock_keeped, :class => Spree::LineItem do
    quantity 1
    stock_keeper_expires_at 1.hour.from_now
    price { BigDecimal.new('10.00') }

    # associations:
    association(:order, :factory => :order)
    association(:variant, :factory => :variant)
  end
end
