unless Spree::Admin::GeneralSettingsController.instance_methods.include?(:update_without_stock_keeper)
  Spree::Admin::GeneralSettingsController.class_eval do
    alias_method :update_without_stock_keeper, :update
    def update
      params.select{|k,v| k =~ /^stock_keeper_/}.each do |name, value|
        Spree::StockKeeper::Config[name] = value
      end
      update_without_stock_keeper 
    end
  end
end
