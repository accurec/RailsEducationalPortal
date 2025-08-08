require "test_helper"

class Student::TermsToPurchaseControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index when student user is signed in" do
    sign_in users(:student_user_one)
    get student_terms_to_purchase_url
    assert_response :success
  end

  test "should redirect to root when non-student user tries to access" do
    sign_in users(:admin_user)
    get student_terms_to_purchase_url
    assert_redirected_to root_path
    assert_equal "You are not authorized to perform this action.", flash[:alert]
  end

  test "should redirect to login when user is not signed in" do
    get student_terms_to_purchase_url
    assert_redirected_to new_user_session_path
  end  
end
