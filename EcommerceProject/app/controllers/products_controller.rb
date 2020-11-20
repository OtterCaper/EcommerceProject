class ProductsController < ApplicationController
  def index
    @products = Product.all.includes(:category).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    # @products = Product.where('name LIKE ?', "%#{params[:search_term]}%")
    @products = Product.search(params[:search_term], params[:search_attribute], params[:sale_attribute], params[:new_attribute]).includes(:category).page(params[:page])
  end
end
