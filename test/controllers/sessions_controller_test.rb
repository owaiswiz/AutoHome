require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login," do
    get sessions_login,_url
    assert_response :success
  end

  test "should get home" do
    get sessions_home_url
    assert_response :success
  end

end
