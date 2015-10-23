Rails.application.routes.draw do
  resources :users
  resources :questions, except: [:destroy]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', :via => :delete
end
