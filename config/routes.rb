# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :users, only: [:show]

  # ランキングページを追加
  get 'rankings', to: 'rankings#index', as: :rankings

  # 管理者用のルート
  namespace :admin do
    root to: 'dashboard#index'
    resources :ruby_methods
    resources :ruby_modules
  end

  resources :games, only: %i[index new create show] do
    member do
      get :result
      post :finish
      get :methods
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
