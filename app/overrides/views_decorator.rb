Deface::Override.new(
  :virtual_path => "spree/admin/general_settings/edit",
  :name => "admin_general_settings_edit_for_stock_keeper",
  :insert_before => "[data-hook='buttons']",
  :partial => "spree/admin/stock_keeper/edit_config",
  :original => '7fef2b5ba2ee3fbef1968731f73cbe4e17d79634',
  :disabled => false)

Deface::Override.new(
  :virtual_path => "spree/orders/edit",
  :name => "spree_orders_edit_for_stock_keeper",
  :insert_before => "[data-hook='outside_cart_form']",
  :text => %!<span class="stock_keeper_cart_form_expiration_info"><%= stock_keeper_remaining_time %></span>!,
  :original => '0b5774f437a257c218490c5846dafd63ea5909a1',
  :disabled => false)

Deface::Override.new(
  :virtual_path => "spree/shared/_main_nav_bar",
  :name => "spree_nav_bar_cart_for_stock_keeper",
  :insert_bottom => "#link-to-cart[data-hook]",
  :text => %!<% unless @order %><span class="stock_keeper_cart_form_expiration_info"><%= stock_keeper_remaining_time %></span><% end %>!,
  :original => '0b575846dafd63ea5909a1',
  :disabled => false)
  
