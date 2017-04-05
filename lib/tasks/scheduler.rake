namespace :notification do
  task due_borrow_book: :environment do
    today = DateTime.parse(Date.today.to_s).strftime("%Y-%m-%d 00:00:00")
    users = User.list_user_duo_borrow_book today
    if users.present?
    users.each do |user|
      requests = Request.list_request_duo_borrow_book user.id, today
      UserMailer.duo_borrow_book(user, requests).deliver
    end
    end
  end
end
