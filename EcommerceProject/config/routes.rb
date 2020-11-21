Rails.application.routes.draw do
  get 'about/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :categories, only: %i[index show]
  resources :cart, only: %i[create destroy]
  resources :products, only: :index
  resources :products, only: :show do
    collection do
      get :search
    end
  end

  root to: 'products#index'
end
