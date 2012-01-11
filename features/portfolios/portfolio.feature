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
        | Name	           | Stocks | CALL | PUT | Initial Investment | Cash	  | 
        | MyAssetPortfolio | 54     |	0    | 0   | ₪150,000           | ₪99,000 |

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
        | Name	           | Stocks | CALL | PUT | Initial Investment | Cash	   | 
        | MyAssetPortfolio | 0      |	4    | -1  | ₪150,000           | ₪146,250 |

    @javascript
    Scenario: Graph View
      Given default portfolio exists with name "MyAssetPortfolio" and default asset
      And current stike is 1100
      And I am not logged in
      When I follow "Portfolios"
      And I follow "MyAssetPortfolio"
      Then I should see P&L Chart with current strike
      When I press on image "Move chart left"
      Then I should see P&L Chart with 1000 strike

