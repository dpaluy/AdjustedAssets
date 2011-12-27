def valid_attributes
  {
    :name => "MyPortfolio",
    :cash_cents => 15000000,
  }
end

Given /^default portfolios exists$/ do
  Portfolio.create! valid_attributes
end

Given /^default portfolio exists with name "([^"]*)"$/ do |arg1|
  attributes = valid_attributes.merge({:name => arg1})
  Portfolio.create!(attributes)
end

