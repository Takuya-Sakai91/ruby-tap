# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :users, only: [:show]

  resources :games, only: %i[new create show] do
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
