require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test 'login with invalid information' do
    # 1-Visit the login path
    get login_path
    # 2-Verify that the new sessions form renders properly.
    assert_template 'sessions/new'
    # 3-Post to the sessions path with an invalid params hash
    post login_path, params: { session: { email: '', password: '' } }
    # 4-Verify that the new sessions form gets re-rendered and that a flash message appears
    assert_not flash.empty?
    # 5-Visit another page(such as home page)
    get root_path
    # 6-Verify that the flash doesn't appear on the new page.
    assert flash.empty?
  end

  test 'login with valid information' do
    # 1- Visit the login path
    get login_path
    # 2- Post valid information to the sessions path
    post login_path params: { session: { email: @user.email, password: 'password'} }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    # 3- Verify that the login link dissapears
    assert_select 'a[href=?]', login_path, count: 0
    # 4- Verify that a logout link appears
    assert_select 'a[href=?]', logout_path
    # 5- Verify that a profile link appears
    assert_select 'a[href=?]', user_path(@user)
  end
end
