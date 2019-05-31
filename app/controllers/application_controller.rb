class ApplicationController < ActionController::Base

  def hello
    render html: " hello i am mr rails :)"
  end
end
