class RespondNotificationJob < ApplicationJob
  queue_as :default

  def perform request
    ActionCable.server.broadcast "notifications_#{request.user_id}",
      book_id: request.book_id,
      book_title: request.book_title,
      status: request.status,
      type: Settings.three
  end
end
