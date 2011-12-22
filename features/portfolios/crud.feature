Feature: Portfolio
  In order to invest money
  As a user
  I want to manage my portfolios

    Scenario: I sign in and create my portfolio
      Given I am a logged in user
      When I follow "Portfolios"
      And I follow "New Portfolio"
      And I fill in the following:
        | Name                | MyPortfolio  |
        | Cash                | 150000       |
        | Strategy multiplier | 1            |
      And I press "Create"
      Then I should see "Portfolio was successfully created."

    Scenario: Not logged in user can't create portfolios
      Given I am not logged in
      And default portfolios exists
      When I follow "Portfolios"
      Then I should not see "New Portfolio"
      And I should not see "Edit"
      And I should not see "Destroy"

    Scenario: Not logged in user can't edit portfolios
      Given I am not logged in
      And default portfolio exists with name "MyTestPortfolio"
      When I follow "Portfolios"
      And I follow "MyTestPortfolio"
      Then I should not see "Edit"
      And I should not see "Destroy"

