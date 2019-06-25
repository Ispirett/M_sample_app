class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  def hello
    render html: " hello i am mr rails :)"
  end


  def authenticated?
    unless logged_in?
      store_searched_url
      flash[:danger] = 'Please log in'
      redirect_to login_url
    end

   def correct_user
     @user = User.find(params[:id])
     redirect_to home_path unless current_user?(@user)
   end

    # Confirms an admin user.
    def admin_user
      redirect_to home_path unless current_user.admin?
    end
  end
end
