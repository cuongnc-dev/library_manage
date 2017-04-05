class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{params['user_id']}"
  end
end
