Rails.application.routes.draw do
  root to: 'items#index'
  resources :mypages
  resources :logouts
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'streets', to: 'users/registrations#new_streets'
    post 'streets', to: 'users/registrations#create_streets'
  end
  resources :sells, only: [:new,:create] do
    collection do
      get :search
    end
  end
  resources :items, only: [:index,:show, :destroy] do
    get 'show_image', :on => :member
    resource :purchases, only: [:show, :update]
  end
  resources :credits, only: [:index, :new, :create, :destroy]

  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
end
