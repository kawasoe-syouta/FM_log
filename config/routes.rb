Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :sells, only: [:index,:create]
  resources :items, only: [:index,:show] do
    resource :purchases, only: [:show, :update]    
  end
  resources :users, only: [:new,:create]
  resources :credits, only: [:index, :show, :new, :create, :destroy]
end
