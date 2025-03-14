class UserMailer < ApplicationMailer
  default from: "aguy230001@gmail.com"

  def account_activation(user)
    @user = user
    user.activation_token = User.new_token
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
