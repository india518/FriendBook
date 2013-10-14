FriendBook::Application.routes.draw do
  get "/register", :to => 'users#new'
  post "/register", :to => 'users#create'

  get "/login", :to => 'sessions#new'
  post "/login", :to => 'sessions#create'
  delete "/logout", :to => 'sessions#destroy'

  resources :users, :only => [:index, :show]

  root :to => 'sessions#new'
end
