Rails.application.routes.draw do

  resources :profiles, only: [:edit, :update]
  resources :line_items, only: [:create]
  resources :orders, except: [:new, :destroy, :edit] do
    get 'accept'
  end
  resources :products, only: [:index, :create, :update]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'home/index'
  root to: 'products#index'
end
