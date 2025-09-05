# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = policy_scope(User).order(created_at: :desc)
    authorize @users
  end
  
  def show
    @user = User.find(params[:id])
    authorize @user
  end
  
  def edit
    @user = User.find(params[:id])
    authorize @user
  end
  
  def update
    @user = User.find(params[:id])
    authorize @user
    
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role,:avatar)
  end
end