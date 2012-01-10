When /^I press on image "([^"]*)"$/ do |alt|
  find(:xpath, "//a/img[@alt='#{alt}']/..").click
end

