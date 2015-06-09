Spree::BaseController.class_eval do
  prepend_before_filter :seek_and_destroy_expired_stock_keepings

  def seek_and_destroy_expired_stock_keepings
    if self.respond_to? :current_order
      co = current_order
      if co.present? && co.stock_keepings_expired?
        current_order.destroy 
        @current_order = nil
      end
    end
  end
end
