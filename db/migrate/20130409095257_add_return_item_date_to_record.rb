class AddReturnItemDateToRecord < ActiveRecord::Migration
  def change
    add_column :records, :return_item_date, :date
    add_column :records, :return_status, :boolean, :default=>false
  end
end
