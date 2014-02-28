class AddPurchasingDateToItem < ActiveRecord::Migration
  def change
    add_column :items, :purchasing_date, :date
  end
end
