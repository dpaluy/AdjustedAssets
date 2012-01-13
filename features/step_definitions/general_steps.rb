When /^I press on image "([^"]*)"$/ do |alt|
  find(:xpath, "//a/img[@alt='#{alt}']/..").click
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "([^"]*)"$/ do |text|
  page.should_not have_content(text)
end

Then /^I go to the home page$/ do
  visit '/'
end

Given /^I am on the home page$/ do
  visit '/'
end

Given /^I go to the sign up page$/ do
  visit '/users/sign_up'
end

Given /^I fill in the following:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.rows_hash.each do |key, value|
    fill_in(key, :with => value)
  end
end

When /^I press "([^"]*)"$/ do |label|
  click_button label
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I go to the homepage$/ do
  visit '/'
end

When /^I follow "([^"]*)"$/ do |text|
  click_link text
end
