class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = " Hey you made it welcome"
     redirect_to  home_path
      session[:session_user_id] = user.id
      elsif
      flash.now[:danger] = "Please correct your email or your password :)"
      render :new
    end

  end

  def destroy

  end

end
