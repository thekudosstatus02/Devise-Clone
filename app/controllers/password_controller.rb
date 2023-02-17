class PasswordController < ApplicationController
  def forgot_password
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        new_password = User.create_random_password
        UserNotifierMailer.forgot_password_alert(@user, new_password).deliver
        @user.update(:password=>new_password)
        redirect_to account_login_url
      else
         flash[:notice] = "Invalid email id. Please enter valid email address"
         render :action=>forgot_password 
      end
    end
  end

  def reset_password
    @user = User.find_by_id(session[:user])
    if request.post?
      puts "============INSIDE THE POST OF RESET PASSWORD"
      puts "============INSIDE THE POST OF RESET PASSWORD#{@user.email}"
      if @user
        puts "============INSIDE THE @USER OF RESET PASSWORD"
        new_password = params[:password]
        @user.update(:password=>new_password)
        UserNotifierMailer.reset_password_alert(@user, new_password).deliver
        redirect_to account_login_url
      else
         flash[:notice] = "Please login to reset password"
         render :action=>reset_password 
      end
    end
  end
end
