class ElanceController < ApplicationController
  def callback
    cache = Dalli::Client.new(Settings.memcache.host,
                              Settings.memcache.username,
                              Settings.memcache.password)
    client = Elance::Authentication.new(Settings.elance.client_id,
                                        Settings.elance.client_secret)
    token = client.get_access_token( params[:code] )
    cache.set('elance_token', token)
    render :text => token
  end
end
