class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :notifications, dependent: :destroy

  validates :content, presence: true, length: {minimum: Settings.min_comment}

  def create_comment_notification comment, users_follow
    content = t "commented_on_book"
    users_follow.each do |user_follow|
      Notification.create user_id: user_follow.id, book_id: comment.book_id,
        comment_id: comment.id, content: content
    end
  end

  delegate :avatar, :name, to: :user, prefix: true
  delegate :title, to: :book, prefix: true

  scope :list_newest_comment, -> {order created_at: :desc}
end
