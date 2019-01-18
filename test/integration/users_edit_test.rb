require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'unsucessful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {name: '',
                                             email: 'foo@invalid',
                                             password: 'foo',
                                             password_confirmation: 'bar' } }
    assert_template 'users/edit'
  end

  test 'invalid edit information' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    assert_no_difference 'User.count' do
    patch user_path(@user), params: { user: { name: '',
                                         email: 'foo@invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'successful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_pat(@user), params: { user: {name: name,
                                            email: email,
                                            password: 'foobar',
                                            password_confirmation: 'foobar'} }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
