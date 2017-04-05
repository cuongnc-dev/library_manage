class Request < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :notifications, dependent: :destroy

  enum status: {processing: 0, accepted: 1, rejected: 2, borrowed: 3, returned: 4}

  validates :start_day, presence: true, date: {after_or_equal_to: Date.today}
  validates :end_day, presence: true, date: {after_or_equal_to: :start_day}

  delegate :email, :name, to: :user, prefix: true
  delegate :id, :title, :current, :image, to: :book, prefix: true

  scope :list_request_newest, -> {order created_at: :desc}
  scope :list_request_by_user, -> id do
    joins(:user).select("requests.*").where "users.id = ?", "#{id}"
  end
  scope :search_request_by_user, -> name do
    joins(:user).select("requests.*").where "users.name like ?", "%#{name}%"
  end
  scope :search_request_by_book, -> title do
    joins(:book).select("requests.*").where "books.title like ?", "%#{title}%"
  end
  scope :search_by_absolute_start_day, -> start_day {where start_day: start_day}
  scope :search_by_relative_start_day, -> from, to do
    where "start_day between ? and ?", "#{from}", "#{to}"
  end
  scope :search_by_absolute_end_day, -> end_day {where end_day: end_day}
  scope :search_by_relative_end_day, -> from, to do
    where "end_day between ? and ?", "#{from}", "#{to}"
  end
  scope :search_by_start_end_day, -> start_day, end_day do
    where "start_day >= ? and end_day <= ?", "#{start_day}", "#{end_day}"
  end
  scope :search_request_by_status, -> status {where status: status}
  scope :list_request_duo_borrow_book, -> user_id, today do
    where "(user_id = ? and end_day = ?) and status = 3", "#{user_id}", "#{today}"
  end

  def update_current_book book_id, bool
    book = Book.find_by id: book_id
    if bool
      book.update_attribute(:current, book.current - 1)
    else
      book.update_attribute(:current, book.current + 1)
    end
  end

  def email_new_request request
    UserMailer.user_send_request(request).deliver_later
  end

  def email_respond_request request
    UserMailer.respond_user_request(request).deliver_later
  end
end
