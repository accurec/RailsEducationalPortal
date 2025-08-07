require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index when not signed in" do
    get root_url
    assert_response :success
  end

  test "should redirect admin user to admin dashboard" do
    sign_in users(:admin_user)
    get root_url
    assert_redirected_to admin_dashboard_path
  end

  test "should redirect student user to student dashboard" do
    sign_in users(:student_user_one)
    get root_url
    assert_redirected_to student_dashboard_path
  end
end
