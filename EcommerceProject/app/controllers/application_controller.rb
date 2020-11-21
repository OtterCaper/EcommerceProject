class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  private

  def initialize_session
    # this will initazlize our shopping cart
    session[:shopping_cart] ||= [] # the shopping cart will be an array of product ids.
  end

  def cart
    Product.find(session[:shopping_cart]) # return a collection of product objects based on the product ids in the shopping cart.
  end
end
