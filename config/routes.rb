Rails.application.routes.draw do
  root 'questions#index'

  resources :users, except: [:destroy]
  resources :questions, except: [:destroy] do
    resources :answers
  end
  post '/questions/vote' => 'questions#vote'
  resources :users, except: [:destroy]
  resources :votes, only: [:new, :create], path: '/:obj_type/:obj_id/votes'
  resources :questions, except: [:destroy]

  get 'register' => 'users#new', as: 'register'
  post 'register' => 'users#create'
  get 'login' => 'sessions#login_form'#, as: 'login'
  post 'login' => 'sessions#login'
  get 'logout' => 'sessions#logout', as: 'logout'
end
