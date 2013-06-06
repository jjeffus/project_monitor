class ElanceController < ApplicationController
  def callback
    #cache = Dalli::Client.new(Settings.memcache.host)
    client = Elance::Authentication.new(Settings.elance.client_id,
                                        Settings.elance.client_secret)
    token = client.get_access_token( params[:code] )
    Rails.cache.set('elance_token', token)
    render :text => token
  end
end
