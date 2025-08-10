# Mock payment processor for educational portal
class PaymentProcessor
  attr_reader :user, :currency

  def initialize(user, currency: 'USD')
    @user = user
    @currency = currency
  end

  # Mock successful payment processing
  def process_course_payment(course, license = nil)
    success_response_course_payment(course, license)
  end

  def process_term_payment(term, license = nil)
    success_response_term_payment(term, license)
  end

  private

  def generate_transaction_id
    "txn_#{SecureRandom.hex(8)}_#{Time.current.to_i}"
  end

  def price
    rand(10.0..100.0).round(2)
  end

  def success_response_course_payment(course, license = nil)
    {
      success: true,
      transaction_id: generate_transaction_id,
      amount: price,
      currency: currency,
      processed_at: Time.current,
      user_id: user.id,
      course_id: course.id,
      payment_method: license ? 'license_code' : 'credit_card',
      status: 'completed'
    }
  end

  def success_response_term_payment(term, license = nil)
    {
      success: true,
      transaction_id: generate_transaction_id,
      amount: price,
      currency: currency,
      processed_at: Time.current,
      user_id: user.id,
      term_id: term.id,
      payment_method: license ? 'license_code' : 'credit_card',
      status: 'completed'
    }
  end
end