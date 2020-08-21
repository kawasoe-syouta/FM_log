Rails.application.routes.draw do
<<<<<<< HEAD
  root to: 'items#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'streets', to: 'users/registrations#new_streets'
    post 'streets', to: 'users/registrations#create_streets'
  end
  resources :sells, only: [:new,:create]
  resources :items, only: [:index,:show, :destroy] do
    resource :purchases, only: [:show, :update]   
  end
  resources :credits, only: [:index, :show, :new, :create, :destroy]
=======
  devise_for :users
  root 'items#index'
  resources :sells, only: [:index,:create,:edit]
  resources :items, only: [:index,:show]
  resources :users, only: [:new,:create]
  resources :purchases, only: :index
>>>>>>> 4a6c796... master commit
end
