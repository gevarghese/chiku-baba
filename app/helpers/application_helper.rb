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

  def devise_error_messages!
    return "" if resource.errors.empty?

    render "devise/shared/error_messages", resource: resource
  end
end
