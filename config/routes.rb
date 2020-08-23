Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'streets', to: 'users/registrations#new_streets'
    post 'streets', to: 'users/registrations#create_streets'
  end
  root 'items#index'
  resources :sells, only: [:index,:create]
  resources :items, only: [:index,:show]
  resources :purchases, only: :index
  resources :credits, only: [:index, :show, :new, :create, :destroy]
end
