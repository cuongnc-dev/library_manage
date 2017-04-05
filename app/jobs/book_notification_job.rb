class BookNotificationJob < ApplicationJob
  queue_as :default

  def perform book, users_follow
    users_follow.each do |user_follow|
      ActionCable.server.broadcast "notifications_#{user_follow.id}",
        username: book.author_name,
        book_id: book.id,
        book_title: book.title,
        type: Settings.one
    end
  end
end
