# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def user_send_request
    request = Request.first
    UserMailer.user_send_request request
  end
end
