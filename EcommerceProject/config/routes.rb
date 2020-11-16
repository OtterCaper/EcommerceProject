Rails.application.routes.draw do
  # get 'products/index'
  # get 'products/show'
  get 'about/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: %i[index show]
  # resources :products, only: :show do
  #   collection do
  #     get :search
  #   end
  # end


  root to: 'products#index'
end
