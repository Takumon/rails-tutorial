class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    param_email = params[:session][:email].downcase
    param_password = params[:session][:password]


    user = User.find_by(email: param_email)

    if user&.authenticate(param_password)
      if user.activated?
        forwarding_url = session[:forwarding_url] # rest前に変数に保持
        reset_session
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        log_in user
        redirect_to forwarding_url || user_url(user)
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
