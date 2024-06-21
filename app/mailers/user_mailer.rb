class UserMailer < ApplicationMailer
  default from: 'bibliotecababel@mail.com'

  def hello(user)
    @user = user
    mail(to: user.email, subject: "Hello")
  end
end
