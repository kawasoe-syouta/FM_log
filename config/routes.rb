Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :sells, only: [:index,:create]
  resources :items, only: [:index,:show]
end
