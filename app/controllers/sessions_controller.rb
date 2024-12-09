class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    param_email = params[:session][:email].downcase
    param_password = params[:session][:password]


    user = User.find_by(email: param_email)

    if user&.authenticate(param_password)
      reset_session
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      log_in user
      redirect_to user_url(user)
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
