PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  #Session routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  #Users
  get '/register', to: 'users#new'
  resources :users, only: [:create, :show, :edit, :update]

  #Posts / comments / categories
  resources :posts, except: :destroy do
    resources :comments, only: [:create, :edit, :update]
  end
  resources :categories, only: [:new, :create, :show]
end
