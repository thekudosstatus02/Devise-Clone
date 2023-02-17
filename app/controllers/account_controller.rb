class AccountController < ApplicationController
  def signup
    @user = User.new
    if request.post?
      @user = User.new(user_params)
      if @user.save
        UserNotifierMailer.signup_alert(@user).deliver
        redirect_to "/account/login", notice: 'Successfully created account'
      else
        render :signup
      end
    end
  end

  def login
    if request.post?
      @user = User.authenticate(params[:email], params[:password])
      if @user
        session[:user] = @user.id
        redirect_to :action=>:dashboard
      else
        flash[:notice] = "Invalid email/password"
        render :action=>:login  
      end
    end
  end

  def logout
    flash[:notice] = "You are logged out"
    session.clear
    redirect_to account_login_url
  end

  def edit_profile
    @user = User.find(session[:user])
    if request.post?
      if @user
        @user.update(:first_name=>params[:first_name], :last_name=>params[:last_name], :mobile=>params[:mobile], :header_image=>params[:header_image])
        redirect_to account_dashboard_url
      else
        flash[:notice] = "Please enter the valid details!"
        render :action=>edit_profile
      end
    end
  end

  def dashboard
    @user = User.find(session[:user])
  end

  private
  def user_params
    params.permit(:first_name,:last_name,:email,:password,:password_confirmation,:encrypted_password,:mobile,:date_of_birth)
  end
end
