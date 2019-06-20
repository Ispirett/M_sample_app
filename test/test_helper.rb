ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
MiniTest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper
  # Add more helper methods to be used by all tests here...
  #
  def is_logged_in?
    !session[:user_id].nil?
  end
  #login as particular user
  def log_in_as(user)
    session[:user_id] = user.id
  end

  class ActionDispatch::IntegrationTest
    #log in as a particular user
    def log_in_as(user, password: 'password', remember_me: '1')
      post login_path, path, params: {seesion: {
          email: user.email,
          password: password,
          remenber_me: remember_me }}
    end
  end

end
