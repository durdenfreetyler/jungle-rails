class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    if params[:category].blank?
      redirect_to new_admin_category_path, alert: "Category cannot be blank."
      return
    end

    existing_category = Category.find_by(name: category_params[:name])
    if existing_category.present?
      redirect_to new_admin_category_path, alert: "Category already exists."
      return
    end

    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: "Category created successfully."
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
