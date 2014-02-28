class AddDefaultValueToStatusAttributeInItem < ActiveRecord::Migration
  def up
    change_column :items, :status, :boolean, :default => false
	end

	def down
    change_column :items, :status, :boolean, :default => nil
	end
end
