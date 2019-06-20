class UsersController < ApplicationController


  def show
    @user =  User.find(params[:id])
  end
  def new
    @user =  User.new
  end

  def create
   @user =  User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.name}"
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end


  # Remembers a user in the database for use in persistent sessions.

private
  def user_params
    params.require(:user).permit(:name ,:email, :password )
  end

end
