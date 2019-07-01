require 'test_helper'

class UserTest < ActiveSupport::TestCase
    def setup
      @user =  User.new(name: 'Max', email: 'max@gmail.com',
                        password: "foobar")
    end
     test "Check if model is valid" do
       assert @user.valid?
     end
      test "Name should be present" do
        @user.name = " "
        assert_not @user.valid?
      end
      test "Email should be present" do
      @user.email = " "
      assert_not @user.valid?
      end

      test  "Name should not be to long" do
        @user.name =  "a" * 56
        assert_not  @user.valid?
       end

     test "Email should not be to long" do
       @user.email = 'a' * 255 + "@gmail.com"
       assert_not @user.valid?
     end

    test "Email validation should except valid addresses" do
      valid_addresses = %w[hao@gmail.com MSJD@outlook.com DHSJSkk32_y@gmail.com Fish_stic_it@gmail.com]
      valid_addresses.each do |address|
        @user.email = address
        assert @user.valid?, "#{address.inspect} should be valid"
      end
    end

     test "Emails should be rejected because they are invalid" do
       invalid_addresses = %w[hsafh,com HElp@gmail,com At@gmail @gmail.com adffda]
       invalid_addresses.each do |email|
         @user.email = email
         assert_not @user.valid?, "#{email} should be invalid"
       end
     end

      test "Emails should be unique" do
        dup_user = @user.dup
        dup_user.email = @user.email.upcase
        @user.save
        assert_not dup_user.valid?
      end

      test "email addresses should be saved as lowercase " do
        mixed_case_email =  "LOL@gmaiL.com"
        @user.email = mixed_case_email
        @user.save
        assert_equal mixed_case_email.downcase, @user.reload.email
      end

    test "password should be present (nonblank)" do
      @user.password = @user.password_confirmation = " " * 6
      assert_not @user.valid?
    end

    test "password should have a minimum length" do
      @user.password = @user.password_confirmation = "a" * 5
      assert_not @user.valid?
    end

    test "authenticate? should return false for a user with nil digest" do
      assert_not @user.authenticated?(:remember,'')
    end
end
