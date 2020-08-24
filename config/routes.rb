Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items, only: [:index,:show]

  resources :sells, only: [:index,:create] do
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
