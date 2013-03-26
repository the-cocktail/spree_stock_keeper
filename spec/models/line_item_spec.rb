require 'spec_helper'

describe Spree::LineItem do
  let!(:variant) { 
    create(:variant)
  }
  context '.stock_keepings_for variant (class method)' do
    it "should return zero if there's no line items" do
      Spree::LineItem.stock_keepings_for(variant).should == 0
    end
    it "should return zero if there's no line items" do
      Spree::LineItem.stock_keepings_for(variant).should == 0
    end
  end
end
