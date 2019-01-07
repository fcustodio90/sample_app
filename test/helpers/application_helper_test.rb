require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    base_title = 'Ruby on Rails Tutorial Sample App'
    assert_equal full_title, base_title.to_s
    assert_equal full_title('Help'), "Help | #{base_title}"
    assert_equal full_title('About'), "About | #{base_title}"
    assert_equal full_title('Contact'), "Contact | #{base_title}"
  end
end
