class ApplicationMailer < ActionMailer::Base
  default from: 'engaging.help@gmail.com'
  layout 'mailer'

  def forgot_email(user)
    @user = user
    mail(to: @user.email, subject: 'Engage recover password')
  end
  
end
