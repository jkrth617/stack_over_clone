Rails.application.routes.draw do
  root 'questions#index'

  resources :users, except: [:destroy]
  resources :questions, except: [:destroy] do
    resources :answers, except: [:show]
  end
  resources :answers do
    resources :comments, only: [:new, :create]
  end

  post '/questions/vote' => 'questions#vote'
  post '/answers/vote' => 'answers#vote'
  resources :votes, only: [:new, :create], path: '/:obj_type/:obj_id/votes'
  resources :tags, only: [:index, :show]

  get 'register' => 'users#new', as: 'register'
  post 'register' => 'users#create'
  get 'login' => 'sessions#login_form'
  post 'login' => 'sessions#login'
  get 'logout' => 'sessions#logout', as: 'logout'
  get '/auth/:provider/callback' => 'sessions#create'

  get '/recent' => 'questions#recent'
end
