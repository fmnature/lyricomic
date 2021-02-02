Rails.application.routes.draw do
  devise_for :users
  root to: "lyrics#index"
  resources :lyrics do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
end
