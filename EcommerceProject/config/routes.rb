Rails.application.routes.draw do
  get 'about/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :categories, only: %i[index show]
  resources :cart, only: %i[create destroy]

  post 'cart/:id/edit', to: 'cart#edit', as: :edit_cart

  resources :products, only: :index
  resources :products, only: :show do
    collection do
      get :search
    end
  end

  root to: 'products#index'
end
