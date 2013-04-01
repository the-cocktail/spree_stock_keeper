Spree::BaseHelper.module_eval do
  def stock_keeper_remaining_time
    if seconds = current_order.stock_keepings_expires_in_seconds and seconds < 121
      unit = t('stock_keeper_seconds')
      t('stock_keeper_edit_order_time_left', :time_amount => seconds, :time_unit => unit)
    else
      minutes = current_order.stock_keepings_expires_in_minutes
      unit = t('stock_keeper_minutes')
      t('stock_keeper_edit_order_time_left', :time_amount => minutes, :time_unit => unit)
    end
  end
end
