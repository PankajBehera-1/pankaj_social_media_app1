Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
  delete 'posts/:id/like', to: 'likes#destroy', as: 'like_destroy'


  resources :posts do
    member do
      post 'like'
      delete 'unlike'
    end
  end

  resources :friendships, only: [:create, :destroy]
  

  root to:'posts#index'
end
