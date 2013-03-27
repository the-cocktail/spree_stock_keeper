module SpreeStockKeeper
  class Engine < Rails::Engine
    engine_name 'spree_stock_keeper'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree.stock_keeper.preferences", :before => :load_config_initializers do |app|
      Spree::StockKeeper::Config = Spree::StockKeeperConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
