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

  resources :sells, only: [:index,:create,:new,:edit] do
    collection do
      get :search
    end
  end
  resources :items, only: [:index,:show, :destroy] do
    resource :purchases, only: [:show, :update,:index] 
    collection do
      get :search
    end  
  end
  resources :credits, only: [:index, :show, :new, :create, :destroy]
  resources :users, only: [:new,:create]

  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
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

  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end

end
