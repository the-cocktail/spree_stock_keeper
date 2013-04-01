require 'spec_helper'

describe Spree::Order do
  let(:order) { Spree::Order.new }
  context "state machine" do
    context "transition to complete" do
      it "should call expire_stock_keepings" do
        order.state = "confirm"
        order.run_callbacks(:create)
        order.should_receive(:expire_stock_keepings!)
        order.next!
      end
    end
    context "transition to payment" do
      it "should call stock_keep_payment_minutes" do
        order.state = "delivery"
        order.stub :total => 10.0
        order.stub(:create_shipment!)
        order.should_receive(:stock_keep_payment_minutes!)
        order.next!
      end
    end
  end
  context "StockKeeper expiration instance methods" do
    before {
      @now = Time.now
      Time.stub(:now).and_return(@now)
    }
    context "with nil expiration time" do
      before {
        order.stub(:stock_keeper_expires_at).and_return(nil)
      }
      context "#stock_keepings_expired?" do
        it "should be false" do
          order.stock_keepings_expired?.should be_false
        end
      end
      context "#stock_keepings_expires_in_seconds" do
        it "should be nil" do
          order.stock_keepings_expires_in_seconds.should be_nil
        end
      end
      context "#stock_keepings_expires_in_minutes" do
        it "should be nil" do
          order.stock_keepings_expires_in_minutes.should be_nil
        end
      end
    end
    context "with future expiration time" do
      before {
        @expiration_seconds = 110.to_f
        expires_at = @now + @expiration_seconds.seconds
        order.stub(:stock_keeper_expires_at).and_return(expires_at)
      }
      context "#stock_keepings_expired?" do
        it "should be false" do
          order.stock_keepings_expired?.should be_false
        end
      end
      context "#stock_keepings_expires_in_seconds" do
        it "should return remaining time in seconds" do
          order.stock_keepings_expires_in_seconds.should == @expiration_seconds
        end
      end
      context "#stock_keepings_expires_in_minutes" do
        it "should return remaining time in absolute minutes" do
          order.stock_keepings_expires_in_minutes.should == 1
        end
      end
    end
  end
end
