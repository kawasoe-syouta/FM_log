Rails.application.routes.draw do
  resources :purchases, only: :index
  root to: 'items#index'
  resources :items, only: [:index, :show, :destroy]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
