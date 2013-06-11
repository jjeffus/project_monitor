class ElanceController < ApplicationController
	def callback
		client = Elance::Authentication.new(ENV["ELANCE_CLIENT_ID"],
																			  ENV["ELANCE_CLIENT_SECRET"])
		token = client.get_access_token(params[:code])
		Rails.cache.set('elance_token', token)
		render :text => token
	end
end