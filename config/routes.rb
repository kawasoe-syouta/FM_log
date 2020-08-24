Rails.application.routes.draw do
  devise_for :users
  resources :sells, only: [:index,:create]
  resources :users, only: [:new,:create]
  resources :purchases, only: :index
  root to: 'items#index'
  resources :items, only: [:index, :show, :destroy]
  resources :credits, only: [:index, :show, :new, :create, :destroy]
end
