# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    # Sample flash messages for testing
    if params[:flash_test]
      case params[:flash_test]
      when 'success'
        flash.now[:notice] = "Welcome to your modern Rails app! Everything is working perfectly."
      when 'error'
        flash.now[:alert] = "This is a sample error message to test the flash system."
      when 'warning'
        flash.now[:warning] = "This is a warning message - please pay attention!"
      when 'info'
        flash.now[:info] = "Here's some helpful information for you."
      end
    end
  end
  
  def test_flash
    flash[:notice] = "Flash message test successful! Your layout is working perfectly."
    redirect_to root_path
  end
end

# Add this to config/routes.rb
# Rails.application.routes.draw do
#   root 'home#index'
#   get 'test_flash', to: 'home#test_flash'
# end