Rails.application.routes.draw do
  # get 'categories/index'
  # get 'categories/show'
  # get 'products/index'
  # get 'products/show'
  get 'about/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]
  # resources :products, only: :show do
  #   collection do
  #     get :search
  #   end
  # end


  root to: 'products#index'
end
