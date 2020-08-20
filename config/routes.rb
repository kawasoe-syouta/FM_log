Rails.application.routes.draw do
  resources :purchases, only: :index
  devise_for :users
  resources :items, only: [:index, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
