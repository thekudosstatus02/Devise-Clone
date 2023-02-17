class UserNotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier_mailer.signup_alert.subject
  #
  def signup_alert(user_data)

    @user_name = user_data.first_name
    mail(to: user_data.email, subject: "Your account as been created")

  end
  
  def forgot_password_alert(user_data, pass)

    @name = user_data.first_name
    @new_pass = pass
    mail(to: user_data.email, subject: "Forgot Password")

  end


  def reset_password_alert(user_data, pass)

    @user_name = user_data.first_name
    @new_pass = pass
    mail(to: user_data.email, subject: "Password has been reset")

  end

end
