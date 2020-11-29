class CartController < ApplicationController
  # POST /cart
  # Data sent as a form data (params)
  def create
    id = params[:id].to_i
    if session[:shopping_cart].select { |key, _value| key.include? id.to_s } == []
      session[:shopping_cart] << { id => 1 }
      product = Product.find(id)
      flash[:notice] = "#{product.name} added to cart"
    end
    redirect_to root_path
  end

  # DELETE /cart/:id
  def destroy
    id = params[:id].to_i
    puts 'destroying'

    hash = session[:shopping_cart].select { |key, _value| key.include? id.to_s }
    session[:shopping_cart].delete(hash[0])
    product = Product.find(id)
    flash[:notice] = "#{product.name} remove from cart"
    redirect_to root_path
  end
end
