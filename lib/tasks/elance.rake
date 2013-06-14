namespace :elance do
  task :token_url => :environment do
    client = Elance::Authentication.new(ENV['ELANCE_CLIENT_ID',
                                        ENV['ELANCE_CLIENT_SECRET']
    token_url = client.request_access_code( 'http://reports.netversa.com/callback' )
    puts token_url
    browser = Mechanize.new
    login_page = browser.get token_url
    login_page.form_with(:id => 'loginForm') do |form|
      username_field = form.field_with(:id => 'login_name')
      username_field.value = ENV['ELANCE_USERNAME']
      password_field = form.field_with(:id => 'password')
      password_field.value = ENV['ELANCE_PASSWORD']
    end.submit
  end
end
