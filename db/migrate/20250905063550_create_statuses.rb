class CreateStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :statuses do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :value, null: false
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :statuses, :slug, unique: true
    add_index :statuses, :value, unique: true
    add_index :statuses, :name, unique: true
  end
end