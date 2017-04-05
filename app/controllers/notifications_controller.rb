class NotificationsController < ApplicationController
  after_action :update_notification_status

  def index
    @notifications = Notification.list_user_notifications_limit current_user.id
  end

  private

  def update_notification_status
    new_notifications = Notification.new_notification current_user.id
    if new_notifications.present?
      new_notifications.each do |notification|
        notification.update_attribute(:status, 1)
      end
    end
  end
end
