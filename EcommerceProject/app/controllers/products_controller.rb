class ProductsController < ApplicationController
  def index
    @products = Product.all.includes(:category).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end
end
