class PagesController < ApplicationController
  def make_redirect
    if user_signed_in?
      redirect_to '/report'
    else
      redirect_to '/users/sign_in'
    end
  end
end
