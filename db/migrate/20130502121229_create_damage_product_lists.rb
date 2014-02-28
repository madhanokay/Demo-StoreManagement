class CreateDamageProductLists < ActiveRecord::Migration
  def change
    create_table :damage_product_lists do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :category_id
      t.integer :location_id

      t.timestamps
    end
  end
end
