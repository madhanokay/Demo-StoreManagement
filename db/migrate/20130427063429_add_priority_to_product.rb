class AddPriorityToProduct < ActiveRecord::Migration
  def change
    add_column :products, :priority, :boolean, :default=>false
  end
end
