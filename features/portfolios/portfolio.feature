Feature: Assets Actions
  In order to proceed strategy
  As a portfolio owner
  I want to summarize my assets
  
    Scenario: Summarize total number of stocks
      Given default portfolio exists with name "MyAssetPortfolio" and assets
        | Quantity | Price |
        | 150      | 1100  |
        | 14       | 1000  |
        | -50      | 1120  |
        | -60      | 1200  |
      And I am not logged in
      When I follow "Portfolios"
      Then I should see the following table rows
        | Name	           | Stocks | CALL | PUT | Cash	       | 
        | MyAssetPortfolio | 54     |	0    | 0   | ₪150,000.00 | 

    Scenario: Summarize total number of options
      Given default portfolio exists with name "MyAssetPortfolio" and options
        | Call Put | Strike | Quantity | Price | Expiration Date |
        | true     | 1000   | 1        | 1250  | 2010-01-31      |
        | true     | 1010   | -2       | 1200  | 2010-01-31      |
        | false    | 1020   | 3        | 1240  | 2010-01-31      |
        | false    | 1030   | -4       | 1230  | 2010-01-31      |
        | true     | 1040   | 5        | 1220  | 2010-01-31      |
      And I am not logged in
      When I follow "Portfolios"
      Then I should see the following table rows
        | Name	           | Stocks | CALL | PUT | Cash	       | 
        | MyAssetPortfolio | 0      |	4    | -1  | ₪150,000.00 | 

        
