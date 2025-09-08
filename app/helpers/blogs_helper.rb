# app/helpers/blogs_helper.rb
module BlogsHelper
  def status_badge_classes(status)
    case status.downcase
    when 'draft'
      'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200'
    when 'published'
      'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200'
    when 'archived'
      'bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-200'
    else
      'bg-gray-100 text-gray-800 dark:bg-gray-900 dark:text-gray-200'
    end
  end
end