class UsersController < ApplicationController
 before_action :user_id, only: [:show, :edit, :update,:destroy]
 before_action :authenticated?, only: [:index, :show, :edit, :update, :destroy]
 before_action :correct_user, only: [:edit, :update]
 before_action :admin_user , only: [:destroy]


 def index
   @users = User.where(activated: true).paginate(page: params[:page])

 end
  def show
    @user =  User.find(params[:id])
    redirect_to root_url unless @user.activated?
  end

  def new
    @user =  User.new
  end

  def create
   @user =  User.new(user_params)
    if @user.save
     # flash[:success] = "Welcome #{@user.name}"
     # log_in @user
     # redirect_back_or(@user)
     @user.send_activation_email
      flash[:info] = 'Hi There please check your email to activate your account'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Your profile successful updated'
      redirect_to @user
     else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'User deleted'
     redirect_to users_url
  end

  # Remembers a user in the database for use in persistent sessions.

private
  def user_params
    params.require(:user).permit(:name ,:email, :password )
  end

  def user_id
    @user = User.find(params[:id])
  end
end
