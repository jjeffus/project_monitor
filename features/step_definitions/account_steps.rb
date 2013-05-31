Given(/^I am on the home page$/) do
    visit "/"
end

Given(/^I am not signed in$/) do
    if page has_content("Sign out")
      click "Sign out"
    end
end

When(/^I enter my account credentials$/) do
    fill_in "Login", :with => "testuser@netversa.com"
    fill_in "Password", :with => "123kkJkS"
end

Then(/^I should see see the message "(.*?)"$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end

Given(/^a user exists/i) do
  @user = FactoryGirl.create(:user, :email => 'testuser@netversa.com', :password => '123kkJkS', :password_confirmation => '123kkJkS')
end

Given(/^I am logged in$/) do
    pending # express the regexp above with the code you wish you had
end

When(/^I click "(.*?)"$/) do |link|
    click_link link
end

Then(/^I should see the message "(.*?)"$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end

Given(/^I am on the report page$/) do
    pending # express the regexp above with the code you wish you had
end

When(/^I view the page$/) do
    pending # express the regexp above with the code you wish you had
end

Then(/^I should see a detailed report$/) do
    pending # express the regexp above with the code you wish you had
end
