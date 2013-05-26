Feature: Account management
  In order to prevent unauthorized access.
  As a end-user.
  I want to be able to perform account functions.

  Background:
    Given a user exists

  Scenario: Login
    Given I am on the home page
    And I am not signed in
    When I sign in
    Then I should see see the message "Signed In"

  Scenario: Logout
    Given I am logged in
    And I am on the report page
    When I click link "Log out"
    Then I should see the message "You have been logged out!"