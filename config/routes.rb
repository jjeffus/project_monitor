ProjectMonitor::Application.routes.draw do
  devise_for :users

  get '/reports', :controller => :reports, :action => :index

  root to: 'reports#index'
end
