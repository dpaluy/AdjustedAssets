require 'factory_girl'

Factory.define :user do |u|
  u.sequence(:name) { |n| "foo#{n}" } 
  u.sequence(:email) { |n| "foo#{n}@example.com" }
  u.password 'please'
end

Factory.define :portfolio do |p|
  p.name "MyPortfolio"
  p.initial_investment 150000
  p.currency "ILS"
end

