class UserMailer < ApplicationMailer

  def hello(user)
    @user = user
    mail(to: user.email, subject: "Hello")
  end
end
