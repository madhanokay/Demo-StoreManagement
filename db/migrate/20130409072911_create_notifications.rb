class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.text :description
      t.boolean :status

      t.timestamps
    end
  end
end
