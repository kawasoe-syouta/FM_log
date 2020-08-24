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

  resources :sells, only: [:index,:new,:create,:edit] do
=======
  devise_for :users
  root 'items#index'
  resources :items, only: [:index,:show]

  resources :sells, only: [:index,:create] do
>>>>>>> e78065a... commit
    collection do
      get :search
    end
  end
<<<<<<< HEAD
  resources :items, only: [:index,:show, :destroy] do
    resource :purchases, only: [:show, :update,:index] 
    collection do
      get :search
    end  
  end
  resources :credits, only: [:index, :show, :new, :create, :destroy]
  resources :users, only: [:new,:create]
=======
>>>>>>> e78065a... commit

  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
<<<<<<< HEAD
=======

>>>>>>> e78065a... commit
end
