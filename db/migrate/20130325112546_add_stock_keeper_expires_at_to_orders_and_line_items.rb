class AddStockKeeperExpiresAtToOrdersAndLineItems < ActiveRecord::Migration
  def self.up
    [:spree_orders, :spree_line_items].each do |table_name|
      change_table(table_name) do |t|
        t.column :stock_keeper_expires_at, :datetime, :default => nil
      end  
    end
  end

  def self.down
    [:spree_orders, :spree_line_items].each do |table_name|
      change_table(table_name) do |t|
        t.remove :stock_keeper_expires_at
      end
    end
  end
end
