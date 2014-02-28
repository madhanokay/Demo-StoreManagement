class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_name
      t.text :location_description

      t.timestamps
    end
  end
end
