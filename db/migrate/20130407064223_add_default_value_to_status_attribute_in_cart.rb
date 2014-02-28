class AddDefaultValueToStatusAttributeInCart < ActiveRecord::Migration
  def up
    change_column :carts, :status, :boolean, :default => false
	end

	def down
    change_column :carts, :status, :boolean, :default => nil
	end
end
