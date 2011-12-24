Feature: Assets Actions
  In order to proceed strategy
  As a portfolio owner
  I want to manage my assets
  
    Scenario: Giving orders to BUY/SELL assets
      Given I am a logged in user
      And default portfolio exists with name "MyAssetPortfolio"
      When I follow "Portfolios"
      And I follow "MyAssetPortfolio"
      And I follow "Assets"
      And I follow "New Action"
      And I fill in the following:
        | Quantity | 150  |
        | Price    | 1100 |
      Then I should be redirected to the 'MyAssetPortfolio' page
      And I should see "Asset was successfully created."
