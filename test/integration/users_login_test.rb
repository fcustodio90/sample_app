require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
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
end
