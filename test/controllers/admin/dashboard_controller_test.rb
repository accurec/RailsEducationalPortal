require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index when admin user is signed in" do
    sign_in users(:admin_user)
    get admin_dashboard_url
    assert_response :success
  end

  test "should redirect to root when non-admin user tries to access" do
    sign_in users(:student_user_one)
    get admin_dashboard_url
    assert_redirected_to root_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should redirect to login when user is not signed in" do
    get admin_dashboard_url
    assert_redirected_to new_user_session_path
  end
end
