Spree::LineItem.class_eval do
  before_save :set_stock_keeper_expires_at

  scope :with_stock_keeped_for, ->(variant) do
    where(['variant_id = ? and stock_keeper_expires_at > ?', variant.id, Time.now])
  end

  def self.stock_keepings_for(variant)
    with_stock_keeped_for(variant).sum(:quantity)
  end

  def sufficient_stock?
    return true if Spree::Config[:allow_backorders]
    if new_record?
      variant.on_hand >= quantity
    else
      variant.on_hand >= (quantity - (self.changed_attributes['quantity'] || quantity).to_i)
    end
  end

  private
    def set_stock_keeper_expires_at
      if self.stock_keeper_expires_at.blank? or self.order_id_changed?
        expires_at = [
          stock_keeper_expires_at,
          order.stock_keeper_expires_at,
          Spree::StockKeeper.expires_at
        ].compact.min
        if order.stock_keeper_expires_at.blank? or order.stock_keeper_expires_at != expires_at
          order.update_column :stock_keeper_expires_at, expires_at
        end
        self.stock_keeper_expires_at = expires_at
      end
    end

end
