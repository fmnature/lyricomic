Rails.application.routes.draw do
  devise_for :users
  root to: "lyrics#index"
  resources :lyrics do
    resources :comments, only: [:create, :destroy]
    resources :likes,    only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show, :edit]  do
    get :followings, on: :member
    get :followers, on: :member
  end
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index

  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
end
