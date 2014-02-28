class AddMoveToDamageToRecord < ActiveRecord::Migration
  def change
    add_column :records, :move_to_damage, :boolean, :default=>false
  end
end
