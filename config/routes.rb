Rails.application.routes.draw do
  resources :executions do
    member do
      post 'execute'
    end
  end
  resources :environments
  resources :scripts
  devise_for :users
  root 'home#index'
  get 'home/index'
end
