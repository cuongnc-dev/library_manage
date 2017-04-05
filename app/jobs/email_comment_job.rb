class EmailCommentJob < ApplicationJob
  queue_as :default

  def perform current_user, users, comment
    users.each do |user|
      UserMailer.comment_notification(current_user, user, comment).deliver
    end
  end
end
