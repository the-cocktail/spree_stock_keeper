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
end
