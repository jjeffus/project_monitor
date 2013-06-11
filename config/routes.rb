ProjectMonitor::Application.routes.draw do
  devise_for :users
  root to: 'reports#index'
end
