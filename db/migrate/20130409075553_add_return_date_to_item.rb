class AddReturnDateToItem < ActiveRecord::Migration
  def change
    add_column :items, :return_date, :date
  end
end
