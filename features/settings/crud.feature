Feature: Settings
  In order to configure settings
  As a user
  I want to manage settings

    Scenario: I sign in and create my settings
      Given I am a logged in user
      When I follow "Settings"
      And I follow "New Setting"
      And I fill in the following:
        | Multiplier            | 100             |
        | Name                  | MyConfig        |
        | Stock fee             | 0.1             |
        | Option fee            | 2.2             |
        | Points to rehedge     | 50              |
        | Supplement cost       | 1000            |    
        | Asset adjustment      | 30              |
      And I press "Create"
      Then I should see "Setting was successfully created." 
    
    Scenario: Not logged in user can't create settings
      Given I am not logged in
      And default settings exists
      When I follow "Settings"
      Then I should not see "New Setting"
      And I should not see "Edit"
      And I should not see "Destroy"
      
    Scenario: Not logged in user can't edit settings
      Given I am not logged in
      And default setting exists with name "MyTestConfig"
      When I follow "Settings"
      And I follow "MyTestConfig"
      Then I should not see "Edit"
      And I should not see "Destroy"
    
