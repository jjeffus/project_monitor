namespace :elance do
  task :token_url => :environment do
    client = Elance::Authentication.new(Settings.elance.client_id,
                                        Settings.elance.client_secret)
    token_url = client.request_access_code( Settings.elance.callback )
    puts token_url
    browser = Mechanize.new
    login_page = browser.get token_url
    login_page.form_with(:id => 'loginForm') do |form|
      username_field = form.field_with(:id => 'login_name')
      username_field.value = Settings.elance.username
      password_field = form.field_with(:id => 'passwd')
      password_field.value = Settings.elance.password
    end.submit
  end
end
