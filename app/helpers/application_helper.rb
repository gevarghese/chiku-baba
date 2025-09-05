# app/helpers/application_helper.rb
module ApplicationHelper
  def admin?
    current_user&.admin?
  end
  
  def moderator?
    current_user&.moderator?
  end

  def user_avatar(user, size: 30)
  if user&.avatar&.attached?
    image_tag user.avatar.variant(resize_to_fill: [size, size]), class: "w-#{size/4} h-#{size/4} rounded-full"
  else
    content_tag :div, class: "w-#{size/4} h-#{size/4} rounded-full bg-gray-300 dark:bg-gray-600 flex items-center justify-center" do
      content_tag :span, class: "text-xs font-bold text-gray-600 dark:text-gray-300" do
        [user&.first_name&.first, user&.last_name&.first].join
      end
    end
  end
end
end
