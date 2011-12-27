require 'factory_girl'

Factory.define :user do |u|
  u.name 'Test User'
  u.email 'user@test.com'
  u.password 'please'
end

Factory.define :portfolio do |p|
  p.name "MyPortfolio"
  p.cash_cents 15000000
  p.currency "ILS"
end

