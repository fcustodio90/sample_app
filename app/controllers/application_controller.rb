class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # Logs in the given user
  def hello
    render html: "hello, world!"
  end
end
