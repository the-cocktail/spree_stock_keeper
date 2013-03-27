Spree::LineItem.class_eval do
  before_save :set_stock_keeper_expires_at

  scope :with_stock_keeped_for, ->(variant) do
    where(['variant_id = ? and stock_keeper_expires_at > ?', variant.id, Time.now])
  end

  def self.stock_keepings_for(variant)
    with_stock_keeped_for(variant).sum(:quantity)
  end

  private
    def set_stock_keeper_expires_at
      if self.stock_keeper_expires_at.blank? or self.order_id_changed?
        if order.stock_keeper_expires_at.blank?
          order.update_column :stock_keeper_expires_at, Spree::StockKeeper.expires_at
        end
        self.stock_keeper_expires_at = order.stock_keeper_expires_at
      end
    end
end
