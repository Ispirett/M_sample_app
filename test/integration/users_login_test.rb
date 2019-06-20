require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Ispire)
  end

  test 'login with invalid information ' do
   get login_path
   assert_template 'sessions/new'
   post login_path, params: { session: { email: "", password: "" } }
   assert_template 'sessions/new'
   assert_not flash.empty?
   get root_path
   assert flash.empty?

  end

  test 'login in with valid information'do
    get login_path
    post login_path , params: { session: {email: @user.email, password: '12345678'} }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to home_path
    #simulate user in another  browser
    delete login_path
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count:0
    assert_select 'a[href=?]', user_path(@user), count:0

  end

  test "login with remembering " do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
    assert_equal FILL_IN, assigns(:user).FILL_IN
  end

  test 'login without remembering' do
    #log in to set the cookie
    log_in_as(@user, remember_me: '1')
    #log in again and verify the cookie is valid
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]

  end

end