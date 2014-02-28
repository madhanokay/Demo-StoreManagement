class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.string :first_name
      t.string :second_name
      t.integer :contact_number
      t.string :position
      t.text :address
      t.integer :user_id, null:false

      t.timestamps
    end
  end
end
