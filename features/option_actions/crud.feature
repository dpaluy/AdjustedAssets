Feature: Option Actions
  In order to proceed strategy
  As a portfolio owner
  I want to manage my options
  
    Scenario: Giving orders to BUY/SELL options
      Given I am a logged in user
      And default portfolio exists with name "MyAssetPortfolio"
      When I follow "Portfolios"
      And I follow "MyAssetPortfolio"
      And I follow "Options"
      And I follow "New Option Action"
      And I fill in the following:
        | Quantity   | 5    |
        | Price      | 1100 |
      And I select the following:
        | Strike     | 1000 |        
        | Exercise date | Jan 12 |
        | CALL/PUT   | CALL |      
      And I press "Create"
      Then I should see "Option action was successfully created."
