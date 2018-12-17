Rails.application.routes.draw do
  # resources :visitors, only: [:new, :create]
  resources :visitors
  # get '/visitors', to: redirect('/')
  root to: 'visitors#new'

end
