require 'factory_girl'

Factory.define :user do |u|
  u.name 'Test User'
  u.email 'user@test.com'
  u.password 'please'
end

Factory.define :portfolio do |p|
  p.name "MyPortfolio"
  p.initial_investment 150000
  p.currency "ILS"
end

