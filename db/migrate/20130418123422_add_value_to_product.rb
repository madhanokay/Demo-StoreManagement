class AddValueToProduct < ActiveRecord::Migration
  def change
    add_column :products, :value, :integer
  end
end
