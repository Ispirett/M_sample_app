require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
  test "invalid sign up information" do
   get sign_up_path
    assert_no_difference 'User.count' do
      post sign_up_path, params: { user: {
          name: "",
          email: "user@invalid",
          password:              "foo",
          password_confirmation: "bar" }
      }
    end
    assert_not flash[:success]
    assert_template 'users/new'
    #assert_select 'div#<CSS id for error explanation>'
    #assert_select 'div.<CSS class for field with error>'
  end
  test "valid sign up information with account activation" do
    get sign_up_path
    assert_difference "User.count" do
      post sign_up_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }

    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_activation_account_path('invalid ', email: user.email)
    assert_not is_logged_in?

    # Valid token, wrong email
    get edit_activation_account_path(user.activation_token, email: 'fail')
    assert_not is_logged_in?
    # valid activation token
    get edit_activation_account_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert flash[:success]
    assert is_logged_in?
  end

end
