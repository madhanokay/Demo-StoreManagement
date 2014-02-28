class AddItemRecieveStatusToRecord < ActiveRecord::Migration
  def change
    add_column :records, :item_recieve_status, :string
  end
end
