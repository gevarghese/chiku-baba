class AddFirstNameLastNameAndRoleToUsers < ActiveRecord::Migration[8.0]
  def change

    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :role, default: 0  
    end  
  end
end
