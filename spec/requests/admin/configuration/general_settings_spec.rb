require 'spec_helper'

describe "Stock Keeper Settings" do
  stub_authorization!

  before(:each) do
    reset_spree_preferences
    visit spree.admin_path
    click_link "Configuration"
    click_link "General Settings"
  end

  context "visiting general settings (admin)" do
    it "should be have the right content" do
      page.should have_field('stock_keeper_reservation_minutes')
    end
  end

  context "editing general settings (admin)" do
    it "should be able to update reservation minutes" do
      fill_in "stock_keeper_reservation_minutes", :with => "60"
      click_button "Update"
      page.should have_field('stock_keeper_reservation_minutes', :with => '60')
    end
  end
end
