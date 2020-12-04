Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/users/edit' => 'devise/registrations#edit' # edit_user_registration_path
  end

  get 'about/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :categories, only: %i[index show]
  resources :cart, only: %i[create destroy]

  post 'cart/:id/edit', to: 'cart#edit', as: :edit_cart
  get 'cart/:id', to: 'cart#destroy', as: :delete_cart

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
    get 'index', to: 'checkout#index', as: 'checkout_index'
  end

  root to: 'products#index'
end
