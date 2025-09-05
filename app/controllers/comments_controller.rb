# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = @blog.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to @blog, notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to @blog, alert: 'Error creating comment.' }
      end
    end
  end

  def update
    authorize @comment
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream
        format.html { redirect_to @blog, notice: 'Comment was successfully updated.' }
      else
        format.html { redirect_to @blog, alert: 'Error updating comment.' }
      end
    end
  end

  def destroy
    authorize @comment
    @comment.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @blog, notice: 'Comment was successfully destroyed.' }
    end
  end

  private
    def set_blog
      @blog = Blog.find_by!(slug: params[:blog_id])
    end

    def set_comment
      @comment = @blog.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end