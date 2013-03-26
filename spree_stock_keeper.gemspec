# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_stock_keeper'
  s.version     = '0.0.1'
  s.summary     = 'TODO: Add gem summary here'
  s.description = 'TODO: Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.summary     = 'Spree Stock Keeper will make temporary stock reservation with each cart addition.'
  s.description = "By default, Spree's inventory levels (Spree::Variant#on_hand) are decremented when order payment is successfully completed. This extension makes temporary reservations when items are added to the cart."
  s.required_ruby_version = '>= 1.9.2'

  s.author    = 'Fernando García Samblas'
  s.email     = 'fernando.gs@gmail.com'
  s.homepage  = 'https://github.com/nando/spree_stock_keeper'

  s.files     = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*']
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.3.2'

  s.add_development_dependency 'capybara', '~> 1.1.2'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'debugger'
end
