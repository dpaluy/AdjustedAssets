def valid_attributes
  {
    :name => "MyPortfolio",
    :number_of_stocks => 100,
    :cash_cents => 15000000,
    :strategy_multiplier => 1,
  }
end

Given /^default portfolios exists$/ do
  Portfolio.create! valid_attributes
end

Given /^default portfolio exists with name "([^"]*)"$/ do |arg1|
  attributes = default_attributes.merge({:name => arg1})
  Portfolio.create!(attributes)
end

