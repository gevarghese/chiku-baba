# app/helpers/application_helper.rb
module ApplicationHelper
  include BlogsHelper
  include UiHelper
  
  def admin?
    current_user&.admin?
  end
  
  def moderator?
    current_user&.moderator?
  end
end
