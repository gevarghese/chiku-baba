# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authorize_admin, except: [:show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

def show
  @category = Category.find_by!(slug: params[:slug])
  
  # Fix the query - make sure it returns a relation, not nil
  @blogs = @category.blogs.published.recent.page(params[:page]).per(10)
  
  # Add debug output to check what's happening
  Rails.logger.debug "Category: #{@category.inspect}"
  Rails.logger.debug "Blogs count: #{@blogs.total_count}"
  Rails.logger.debug "Blogs class: #{@blogs.class}"
end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Category was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
  end

  private
    def set_category
      @category = Category.friendly.find(params[:slug])

    end



    def category_params
      params.require(:category).permit(:name, :description)
    end
    
    def authorize_admin
      redirect_to root_path, alert: 'Not authorized' unless current_user&.admin?
    end
end