Deface::Override.new(
  :virtual_path => "spree/admin/general_settings/edit",
  :name => "admin_general_settings_edit_for_stock_keeper",
  :insert_before => "[data-hook='buttons']",
  :partial => "spree/admin/stock_keeper/edit_config",
  :original => '7fef2b5ba2ee3fbef1968731f73cbe4e17d79634',
  :disabled => false)
