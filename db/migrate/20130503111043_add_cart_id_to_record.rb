class AddCartIdToRecord < ActiveRecord::Migration
  def change
    add_column :records, :cart_id, :integer
  end
end
