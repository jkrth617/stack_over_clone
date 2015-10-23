Rails.application.routes.draw do
  root 'questions#index'

  resources :users
  resources :questions, except: [:destroy] do
    resources :answers
  end

  get '/recent' => 'answers#recent'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', :via => :delete
end
