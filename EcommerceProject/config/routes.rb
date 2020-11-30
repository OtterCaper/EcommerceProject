Rails.application.routes.draw do
  devise_for :users
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

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  root to: 'products#index'
end
