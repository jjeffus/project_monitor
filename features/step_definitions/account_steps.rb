Given(/^I am on the home page$/) do
  visit "/"
end

Given(/^I am not signed in$/) do
  if page.has_content? "Sign out"
    click "Sign out"
  end
end

When(/^I sign in$/) do
  sign_in
end

When(/^I click button "(.*?)"$/) do |button|
  click_button button 
end

Then(/^I should see see the message "(.*?)"$/) do |message|
  page.has_content? message
end

Given(/^a user exists/i) do
  @user = FactoryGirl.create(:user, :email => 'testuser@netversa.com', :password => '123kkJkS', :password_confirmation => '123kkJkS')
end

Given(/^I am logged in$/) do
  sign_in
end

When(/^I click link "(.*?)"$/) do |link|
  click_link link 
end

Then(/^I should see the message "(.*?)"$/) do |message|
  page.has_content? message
end

Given(/^I am on the report page$/) do
  visit "/report"
end

Then(/^I should see a detailed report containing "(.*?)"$/) do |site_name|
  page.has_content? site_name
end
