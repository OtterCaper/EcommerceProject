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

  def edit
    id = params[:id].to_i
    hash = session[:shopping_cart].select { |key, _value| key.include? id.to_s }
    value = hash[0].values[0]

    puts 'test here'
    # //check value
    if params[:add] == 'true'
      # session[:shopping_cart].find(hash) = { id => hash[0].values[0] + 1 }
      hash[0].update({ id => value + 1 }) # { id => hash[0].values[0] + 1 }
    elsif params[:add] == 'false'
      hash[0].update({ id => value - 1 }) if value > 1

    end
    redirect_to root_path
  end

  # DELETE /cart/:id
  def destroy
    id = params[:id].to_i
    hash = session[:shopping_cart].select { |key, _value| key.include? id.to_s }
    session[:shopping_cart].delete(hash[0])
    product = Product.find(id)
    flash[:notice] = "#{product.name} remove from cart"
    redirect_to root_path
  end
end
