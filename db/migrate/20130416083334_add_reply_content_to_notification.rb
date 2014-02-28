class AddReplyContentToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :reply_content, :text
  end
end
