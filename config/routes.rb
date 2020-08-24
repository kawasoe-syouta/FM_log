Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users
  resources :sells, only: [:index,:create]
  resources :items, only: [:index,:show, :destroy] do
    resource :purchases, only: [:show, :update]    
  end
  resources :users, only: [:new,:create]
  resources :credits, only: [:index, :show, :new, :create, :destroy]
end
