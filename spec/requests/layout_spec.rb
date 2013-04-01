require 'spec_helper'

describe "Stock Keeper layout" do
  before(:each) do
    @reservation_seconds = 30 * 60
    Spree::StockKeeper::Config[:stock_keeper_reservation_minutes] = @reservation_seconds / 60
  end

  it "should render expiration seconds as a body's data attribute" do
    visit '/'
    page.should have_xpath("//body[@data-stock_keepings_expires_in_seconds='']")
  end

  it "should render expiration seconds as a body's data attribute" do
    create(:product, :name => "RoR Mug", :on_hand => 1)
    visit spree.root_path
    click_link "RoR Mug"
    click_button "add-to-cart-button"
    page.should have_xpath("//body[@data-stock_keepings_expires_in_seconds='#{@reservation_seconds-1}']")
  end
end
