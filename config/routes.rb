ProjectMonitor::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  get '/pages/make_redirect', :controller => :pages, :action => :make_redirect
  get '/report', :controller => :reports, :action => :index
  get '/callback', :controller => :elance, :action => :callback
  root :to => redirect("/pages/make_redirect")
end
