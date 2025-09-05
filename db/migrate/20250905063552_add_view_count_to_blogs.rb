class AddViewCountToBlogs < ActiveRecord::Migration[8.0]
  def change
    add_column :blogs, :view_count, :integer, default: 0
  end
end