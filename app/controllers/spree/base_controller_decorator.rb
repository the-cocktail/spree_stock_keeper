Spree::BaseController.class_eval do
  prepend_before_filter :seek_and_destroy_expired_stock_keepings

  def seek_and_destroy_expired_stock_keepings
    if self.respond_to? :current_order
      # Si el order_id de la session apunta a una order que no existe, lo ponemos a nil
      if session[:order_id] && Spree::Order.find_by_id(session[:order_id]).nil?
        session[:order_id] = nil
      end

      # Si no tenemos order_id en la session y la última order en estado "cart" ha expirado, la eliminamos
      # para que después spree cree una nueva
      user = try_spree_current_user
      if session[:order_id].nil? && user.try(:last_incomplete_spree_order)
        if user.last_incomplete_spree_order.stock_keepings_expired?
          user.last_incomplete_spree_order.destroy
        end
      end

      co = current_order

      if co.present? && co.stock_keepings_expired?
        current_order.destroy 
        @current_order = nil
        session[:order_id] = nil
      end
    end
  end
end
