class Spree::StockKeeper
  def self.expires_at
    Spree::StockKeeper::Config[:stock_keeper_reservation_minutes].to_i.minutes.from_now
  end
end
