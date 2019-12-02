class Api::V1::CategoriesController < ApplicationController
  def index
    @categories = [Category.random.to_h, *Category.all]
    render json: @categories
  end

  def show
    if params[:id] == "random"
      render json: Category.random.to_h, status: :ok
    else
      render json: @category = Category.find(params[:id]), status: :ok, include: ['cards']
    end
    # render json: @category, status: :ok, include: ['cards']
  end
end
