Given /^I am a logged in user$/ do
  step %{I am a user named "foo" with an email "user@test.com" and password "please"}
  step %{I sign in as "user@test.com/please"}
end

