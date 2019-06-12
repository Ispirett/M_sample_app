require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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
  test "valid sign up information" do
    get sign_up_path
    assert_difference "User.count" do
      post sign_up_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }

   end
    follow_redirect!
    assert_template 'users/show'
    assert flash[:success]
  end

end
