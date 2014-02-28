class AddSubjectToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :subject, :string
  end
end
