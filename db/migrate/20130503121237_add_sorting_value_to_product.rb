class AddSortingValueToProduct < ActiveRecord::Migration
  def change
    add_column :products, :sorting_value, :integer
  end
end
