# app/controllers/blogs_controller.rb
class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authorize_blog, except: [:index, :new, :create]

  def index
    @blogs = policy_scope(Blog).published.includes(:user, :category).recent
    @featured_blogs = Blog.featured.limit(3)
    @categories = Category.all
  end

def show
  @comment = Comment.new
  @comments = @blog.comments.root_comments.includes(:user, :replies)
  @blog = Blog.friendly.find(params[:slug])

  # Unique view tracking with Solid Cache (per session, expires in 24h)
  cache_key = "blog:#{@blog.id}:viewer:#{session.id}"

  unless SolidCache.read(cache_key)
    @blog.increment!(:view_count)
    SolidCache.write(cache_key, true, expires_in: 24.hours)

    # Turbo Stream update (only when incremented)
    Turbo::StreamsChannel.broadcast_replace_to(
      "blog_stats",
      target: "blog_#{@blog.id}_views",
      partial: "blogs/view_count",
      locals: { blog: @blog }
    )
  end
end



  def new
    @blog = current_user.blogs.new
    authorize @blog
  end

  def edit
  end

  def create
    @blog = current_user.blogs.new(blog_params)
    authorize @blog

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_blog
      @blog = Blog.find_by!(slug: params[:id])
    end

    def authorize_blog
      authorize @blog
    end

    def blog_params
      params.require(:blog).permit(:title, :content, :published_at, :featured, :category_id, :featured_image,:status)
    end
end