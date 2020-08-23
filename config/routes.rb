Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'streets', to: 'users/registrations#new_streets'
    post 'streets', to: 'users/registrations#create_streets'
  end
  resources :sells, only: [:index,:create]
  resources :items, only: [:index,:show, :destroy] do
    resource :purchases, only: [:show, :update]    
  end
  resources :credits, only: [:index, :show, :new, :create, :destroy]
end
