class RemoveContentFromBlog < ActiveRecord::Migration[8.0]
  def change
    remove_column :blogs, :content, :text
  end
end
