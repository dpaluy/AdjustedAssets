def valid_attributes
  {
    :name => "MyPortfolio",
    :initial_investment => 150000,
  }
end

Given /^default portfolios exists$/ do
  Portfolio.create! valid_attributes
end

Given /^default portfolio exists with name "([^"]*)"$/ do |arg1|
  attributes = valid_attributes.merge({:name => arg1})
  Portfolio.create!(attributes)
end

Given /^default portfolio exists with name "([^"]*)" and default asset$/ do |name|
  step %{default portfolio exists with name "#{name}"}
  portfolio = Portfolio.where(:name => name).first
  portfolio.asset_actions.create!(:quantity => 100, :price_cents => 15000000)
end

Then /^I should see P&L Chart with (\d+) strike$/ do |strike|
  begin
    low_strike = strike.to_i - 150
    high_strike = strike.to_i + 150
    default_chart_size = (high_strike - low_strike)/10 + 1
    portfolio_value = evaluate_script('portfolio_value')
    portfolio_value.length.should eq(default_chart_size)
    portfolio_value.first[0].should eq(low_strike)
    portfolio_value.last[0].should eq(high_strike)
  rescue Capybara::NotSupportedByDriverError
  end
end

Given /^current stike is (\d+)$/ do |arg1|
  @current_strike = arg1
end

Then /^I should see P&L Chart with current strike$/ do
  @current_strike = 1000 if @current_strike.nil?
  step %{I should see P&L Chart with #{@current_strike.to_i} strike}
end

