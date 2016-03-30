Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :profiles, only: [:edit, :update]
  resources :orders, except: [:new, :destroy, :edit] do
    get 'accept'
  end
  resources :products, only: [:index]

  root to: 'products#index'
end
