Feature: Report
  In order to allow stakeholders to view current development progress.
  As a logged-in user.
  I want to be able to view a report of development progress.

 Scenario: Report
  Given I am logged in
  And I am on the report page
  Then I should see a detailed report containing "Github"