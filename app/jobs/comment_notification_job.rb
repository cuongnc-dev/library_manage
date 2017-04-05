class CommentNotificationJob < ApplicationJob
  queue_as :default

  def perform comment, users_follow
    users_follow.each do |user_follow|
      ActionCable.server.broadcast "notifications_#{user_follow.id}",
        username: comment.user_name,
        book_id: comment.book_id,
        book_title: comment.book_title,
        type: Settings.zero
    end
  end
end
