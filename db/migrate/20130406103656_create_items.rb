class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :user_id
      t.float :total
      t.integer :cart_id
      t.boolean :status

      t.timestamps
    end
  end
end
