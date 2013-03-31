Spree::BaseController.class_eval do
  prepend_before_filter :seek_and_destroy_expired_stock_keepings

  def seek_and_destroy_expired_stock_keepings
    current_order.destroy if current_order(true).stock_keepings_expired?
  end
end
