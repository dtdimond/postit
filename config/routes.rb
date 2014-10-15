PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  #Session routes
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  #Users
  resources :users, only: :create

  #Posts / comments / categories
  resources :posts, except: :destroy do
    resources :comments, only: :create
  end
  resources :categories, only: [:new, :create, :show]
end
