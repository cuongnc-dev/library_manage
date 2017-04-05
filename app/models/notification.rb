class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :comment
  belongs_to :request

  validates :user_id, presence: true

  delegate :name, to: :user, prefix: true
  delegate :title, to: :book, prefix: true
  delegate :status, to: :request, prefix: true

  scope :list_user_notifications_limit , -> user_id do
    where("user_id = ?", user_id).order(created_at: :desc).limit(Settings.ten)
  end
  scope :new_notification , -> user_id do
    where "user_id = ? and status = ?", user_id, Settings.zero
  end
  scope :search_request_notification , -> request_id, type do
    where "request_id = ? and type_notification = ?", request_id, Settings.three
  end
end
