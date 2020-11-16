class CategoriesController < ApplicationController
  def index
    @categories = Category.all.includes(:products)
  end

  def show
    @category = Category.find(params[:id])
  end
end
