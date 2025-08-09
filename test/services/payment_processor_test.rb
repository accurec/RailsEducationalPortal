require "test_helper"

class PaymentProcessorTest < ActiveSupport::TestCase
  def setup
    @user = users(:student_user_one)
    @course = courses(:course_one)
    @payment_processor = PaymentProcessor.new(@user)
  end

  test "processes payment successfully" do
    result = @payment_processor.process_payment(@course)
    
    assert result[:success]
    assert result[:transaction_id].present?
    assert result[:amount].present?
    assert result[:currency].present?
    assert result[:processed_at].present?
    assert_equal @user.id, result[:user_id]
    assert_equal @course.id, result[:course_id]
    assert_equal "credit_card", result[:payment_method]
    assert_equal "completed", result[:status]
  end

  test "generates unique transaction ids" do
    result1 = @payment_processor.process_payment(@course) 
    result2 = @payment_processor.process_payment(@course)
    
    assert_not_equal result1[:transaction_id], result2[:transaction_id]
  end
end 