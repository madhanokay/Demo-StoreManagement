class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.integer :trigger
      t.date :purchase_date
      t.float :price
      t.integer :location_id, null:false
      t.integer :category_id, null:false

      t.timestamps
    end
  end
end
