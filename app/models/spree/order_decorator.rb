unless Spree::Order.instance_methods.include? :expire_stock_keepings!
  Spree::Order.class_eval do
    state_machine.before_transition :to => :payment, :do => :stock_keep_payment_minutes!
    state_machine.before_transition :to => :complete, :do => :expire_stock_keepings!
  
    def expire_stock_keepings!
      stock_keeper_expires_at! Time.now
    end
    
    def stock_keep_payment_minutes!
      stock_keeper_expires_at! 10.minutes.from_now
    end

    def stock_keepings_expired?
      stock_keeper_expires_at < Time.now
    end
  
    private
  
    def stock_keeper_expires_at!(timestamp)
      update_column :stock_keeper_expires_at, timestamp
      line_items.each {|li| li.update_column :stock_keeper_expires_at, timestamp}
    end
  end
end
