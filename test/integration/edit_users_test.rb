require 'test_helper'

class EditUsersTest < ActionDispatch::IntegrationTest
  def setup
    @user =  users(:Ispire)

  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user:{
        name: '', email:'fdfd', password: '2',
        password_conformation: '3',
    }}
    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 3 errors.'
  end

  test 'successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'update true'
    email = 'hello@gmail.com'
    patch user_path(@user), params:{
        user:{
            name: name,
            email: email,
            password: '',
            password_confirmation: ''
        }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end


end
