module Spree
  class StockKeeperConfiguration < Preferences::Configuration
    preference :stock_keeper_reservation_minutes, :integer, :default => 30
  end
end
