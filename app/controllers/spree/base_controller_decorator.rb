Spree::BaseController.class_eval do
  prepend_before_filter :seek_and_destroy_expired_stock_keepings

  def seek_and_destroy_expired_stock_keepings
    if self.respond_to? :current_order
      co = current_order(true)
      current_order.destroy if co.stock_keepings_expired? and co.payments.blank?
    end
  end
end
