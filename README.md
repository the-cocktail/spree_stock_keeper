SpreeStockKeeper: Temporary inventory items reservation

Spree Stock Keeper will make temporary stock reservation with each cart addition. By default, Spree's inventory levels (Spree::Variant#on_hand) are decremented when order payment is successfully completed. This extension makes temporary reservations when items are added to the cart.

## Installation

1. Add the following line to your application's Gemfile after the `gem 'spree'` line:

        gem 'spree_stock_keeper', :git => 'git://github.com/nando/spree_stock_keeper.git'

2. Install the gem using Bundler:

        bundle install

3. Copy & run migrations

        bundle exec rails g spree_stock_keeper:install
