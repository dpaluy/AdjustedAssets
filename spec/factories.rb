require 'factory_girl'

Factory.define :user do |u|
  u.name 'Test User'
  u.email 'user@test.com'
  u.password 'please'
end

Factory.define :portfolio do |p|
  p.name "MyPortfolio"
  p.number_of_stocks 100
  p.cash_cents 15000000
  p.currency "ILS"
  p.strategy_multiplier 1
end

Factory.define :asset_action do |a|
  a.price_cents 19878
  a.quantity 10
end
