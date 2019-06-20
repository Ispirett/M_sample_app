class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = " Hey you made it welcome"
      #save user to cookies
      log_in(user)
      params[:session][:remember_me]  == '1' ? remember(user) : forget(user)

      redirect_to user
      elsif
      flash.now[:danger] = "Please correct your email or your password :)"
      render :new
    end

  end

  def destroy
    log_out if logged_in?
    redirect_to home_path
  end

end
