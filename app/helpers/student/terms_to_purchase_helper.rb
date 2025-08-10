module Student::TermsToPurchaseHelper
  def process_term_purchase(term, user, payment_result)
    payment_method = determine_payment_method(payment_result[:payment_method])
    
    ActiveRecord::Base.transaction do
      term_purchase = create_term_purchase(term, user, payment_method)
      courses_added = create_course_purchases(term, user, payment_method)
      
      {
        success: true,
        term_purchase: term_purchase,
        courses_added: courses_added
      }
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to purchase #{term.name}: #{e.message}")
    { success: false, error: e.message }
  end
  
  private
  
  def create_term_purchase(term, user, payment_method)
    user.term_purchases.create!(
      term: term,
      purchased_at: Time.current,
      payment_method: payment_method
    )
  end
  
  def create_course_purchases(term, user, payment_method)
    unpurchased_courses = term.courses.where.not(
      id: user.purchased_courses.select(:id)
    )

    unpurchased_courses_count = unpurchased_courses.count
    
    unpurchased_courses.each do |course|
      user.course_purchases.create!(
        course: course,
        purchased_at: Time.current,
        payment_method: payment_method
      )
    end
    
    unpurchased_courses_count
  end

  def determine_payment_method(payment_method_string)
    case payment_method_string
    when 'credit_card'
      TermPurchase.payment_methods[:credit_card]
    when 'license_code'
      TermPurchase.payment_methods[:license_code]
    else
      TermPurchase.payment_methods[:other]
    end
  end
end
