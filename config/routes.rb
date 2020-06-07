Rails.application.routes.draw do
  resources :executions do
    member do
      post 'action'
    end
  end
  resources :environments
  resources :scripts do
    member do
      post 'action'
    end
  end
 
  devise_for :users
  root 'home#index'
  get 'home/index'
end
