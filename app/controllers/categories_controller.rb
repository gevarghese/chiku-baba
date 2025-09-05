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
  puts "Category found: #{@category.name}"
  puts "Category ID: #{@category.id}"
  
  # Check if there are any blogs in this category
  all_blogs = @category.blogs
  puts "Total blogs in category: #{all_blogs.count}"
  puts "Blog titles: #{all_blogs.map(&:title)}"
  
  # Check published blogs
  published_blogs = @category.blogs.published
  puts "Published blogs count: #{published_blogs.count}"
  puts "Published blogs: #{published_blogs.map(&:title)}"
  
  @blogs = published_blogs.recent.page(params[:page]).per(10)
  puts "Paginated blogs: #{@blogs.count}"
  puts "Blogs object: #{@blogs.inspect}"
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