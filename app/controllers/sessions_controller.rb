class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = " Hey you made it welcome"
      #save user to cookies
      remember user
      log_in(user)
      redirect_to user
      elsif
      flash.now[:danger] = "Please correct your email or your password :)"
      render :new
    end

  end

  def destroy
    log_out
    redirect_to home_path
  end

end
