require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'Ruby on Rails Tutorial Sample App'
  end

  test 'should get new' do
    get signup_path
    assert_response :success
    assert_select 'title', "Sign up | #{@base_title}"
  end

  test 'should redirect edit when not logged in ' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
