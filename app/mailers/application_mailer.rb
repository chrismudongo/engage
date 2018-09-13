class ApplicationMailer < ActionMailer::Base
  default from: 'engaging.help@gmail.com'
  layout 'mailer'

  def forgot_email(user)
    @user = user
    mail(to: @user.email, subject: 'Engage Password Recovery')
  end

end
