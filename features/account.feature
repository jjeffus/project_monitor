Feature: Account management
  In order to prevent unauthorized access.
  As a end-user.
  I want to be able to perform account functions.

  Scenario: Login
    Given I am on the home page
    And I am not signed in
    When I enter my account credentials
    Then I should see see the message "Signed In"

  Scenario: Logout
    Given I am logged in
    When I click "Logout"
    Then I should see the message "You have been logged out!"
