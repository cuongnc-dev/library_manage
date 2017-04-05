class EmailBookJob < ApplicationJob
  queue_as :default

  def perform users, book
    users.each do |user|
      UserMailer.book_notification(user, book).deliver
    end
  end
end
