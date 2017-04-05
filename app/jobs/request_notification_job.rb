class RequestNotificationJob < ApplicationJob
  queue_as :default

  def perform request, admins
    admins.each do |admin|
      ActionCable.server.broadcast "notifications_#{admin.id}",
        username: request.user_name,
        book_title: request.book_title,
        type: Settings.two
    end
  end
end
