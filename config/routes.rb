Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :sells, only: [:index,:create]
  resources :items, only: [:index,:show,:edit]
  resources :users, only: [:new,:create]
  resources :purchases, only: :index

  resources :sells do
    collection do
      get :search
    end
  end
  resources :items do
    collection do
      get :search
    end
  end

  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
end
