class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart
  helper_method :provinces

  private

  def initialize_session
    # this will initazlize our shopping cart
    session[:shopping_cart] ||= [] # the shopping cart will be an array of product ids.
  end

  def cart
    products = []
    if session[:shopping_cart] != []
      session[:shopping_cart].each do |item|
        products << { Product.find(item.keys[0]) => item.values[0] }
      end
    end
    puts 'object'
    puts products
    products
  end

  def provinces
    Province.all
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password Province_id address postalcode])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email password password_confirmation current_password Province_id address postalcode])
  end
end
