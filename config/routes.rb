Rails.application.routes.draw do
  devise_for :users, :controllers => {sessions: 'users/sessions', registrations: 'users/registrations'}
  # resources :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
 
  resources :friendships, only: [:destroy]
  post "/friendships/:friend_id", to: "friendships#create", as: "friendships"
  

  root to:'posts#index'
end