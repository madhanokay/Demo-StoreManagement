class AddDeleteStatusToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :delete_status, :boolean, :default=>false
  end
end
