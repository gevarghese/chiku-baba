class CreateBlogs < ActiveRecord::Migration[8.0]
  def change
    create_table :blogs do |t|
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.string :slug, null: false
      t.datetime :published_at
      t.boolean :featured, default: false
      t.references :status, :user, null: false, foreign_key: true, default: 1

      t.timestamps
    end
    
    add_index :blogs, :slug, unique: true
  end
end