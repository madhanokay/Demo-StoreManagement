class AddMoveToQueToCart < ActiveRecord::Migration
  def change
    add_column :carts, :move_to_que, :boolean, :default => false
  end
end
