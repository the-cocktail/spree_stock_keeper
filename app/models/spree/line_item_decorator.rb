Spree::LineItem.class_eval do
  scope :with_stock_keeped_for, ->(variant) do
    where(['variant_id = ? and stock_keeper_expires_at > ?', variant.id, Time.now])
  end

  def self.stock_keepings_for(variant)
    with_stock_keeped_for(variant).sum(:quantity)
  end
end
