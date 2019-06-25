require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Ispire)
    @user_two = users(:Nicketa)
  end
  test "should get new" do
    get sign_up_path
    assert_response :success
    #assert_select :title, 'SignUp | Ruby on Rails Tutorial Sample App'
  end

  test 'should redirect edit when logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url

  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@user_two)
    get edit_user_path(@user)
    assert  flash.empty?
    assert_redirected_to home_path
  end
    test "should redirect update when logged in as wrong user" do
      log_in_as(@user_two)
      patch user_path(@user), params: { user: { name: @user.name,
                                                email: @user.email } }
      assert flash.empty?
      assert_redirected_to home_path
    end

    test "should redirect index when not logged in" do
      get users_path
      assert_redirected_to login_url
    end

    test 'should not allow admin attribute to be edit via the web' do
      log_in_as(@user_two)
      assert_not @user_two.admin?
      patch user_path(@user_two),params: {
          user:{
              password: 'password',
              password_confirmation: 'password',
              admin:1
          }
      }
      assert_not @user_two.name.admin?
    end

    test "should redirect destroy when not logged in" do
      assert_no_difference 'User.count' do
        delete users_path(@user)
      end
      assert_redirected_to login_url

    end

    test 'should redirect destroy when logged in as non admin ' do
      log_in_as(@user_two)
      assert_no_difference 'User.count'do
        delete users_path(@user)
      end
      assert_redirected_to root_url

    end
end
