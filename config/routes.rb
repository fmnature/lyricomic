Rails.application.routes.draw do
  devise_for :users
  root to: "lyrics#index"
  resources :lyrics
  resources :users, only: :show
end
