# app/helpers/application_helper.rb
module ApplicationHelper
  def admin?
    current_user&.admin?
  end
  
  def moderator?
    current_user&.moderator?
  end
end
