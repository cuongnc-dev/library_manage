class AddCommentIdToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :notifications, :comment, foreign_key: true
  end
end
