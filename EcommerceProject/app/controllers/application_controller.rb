class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  private

  def initialize_session
    # this will initazlize our shopping cart
    session[:shopping_cart] ||= [{}] # the shopping cart will be an array of product ids.
  end

  def cart
    products = []
    session[:shopping_cart].each do |item|
      products << Product.find(item.keys[0])
    end
    products
  end
end
