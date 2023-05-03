Rails.application.routes.draw do
  resources :notifications
  resources :statement_requests
  resources :transactions
  resources :accounts
  resources :users, param: :_id
  post '/auth/login', to: 'authentication#authenticate'
  get '/dashboard', to: 'transactions#dashboard'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
