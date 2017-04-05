class ChangeColumnNameNotification < ActiveRecord::Migration[5.0]
  def change
    rename_column :notifications, :type, :type_notification
  end
end
