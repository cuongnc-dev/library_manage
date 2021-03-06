Rails.application.routes.draw do
  root "static_pages#index"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  post "admin/login", to: "sessions#create_admin"
  delete "logout", to: "sessions#destroy"
  delete "admin/logout", to: "sessions#destroy_admin"

  resources :users
  resources :books
  resources :authors, only: :show
  resources :publishers
  resources :comments
  resources :rates, only: [:create, :update]
  resources :likes, only: [:create, :destroy]
  resources :follow_books, only: [:create, :destroy]
  resources :follow_authors, only: [:create, :destroy]
  resources :requests
  resources :notifications, only: :index
  resources :account_activations, only: [:new, :create, :edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  namespace :admin do
    root "books#index"
    get "login", to: "admin#new"
    get "search", to: "admin#index"
    resources :books
    resources :authors
    resources :publishers
    resources :categories
    resources :subcategories
    resources :requests
    resources :users
  end
  mount ActionCable.server => "/cable"
  mount Ckeditor::Engine => "/ckeditor"
end
