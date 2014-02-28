class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :user_id
      t.integer :quantity
      t.date :purchase_date
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end
  end
end
