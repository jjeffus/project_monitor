module SignInHelper
	def sign_in
		visit "/users/sign_in"
    fill_in "user_email", :with => "testuser@netversa.com"
    fill_in "user_password", :with => "123kkJkS"
    click_button "Sign in"
  end
end

World(SignInHelper)