class CartController < ApplicationController
  # POST /cart
  # Data sent as a form data (params)
  def create
    id = params[:id].to_i
    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id
      product = Product.find(id)
      flash[:notice] = "#{product.name} added to cart"
    end
    redirect_to root_path
  end

  # DELETE /cart/:id
  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    product = Product.find(id)
    flash[:notice] = "#{product.name} remove from cart"
    redirect_to root_path
  end
end
