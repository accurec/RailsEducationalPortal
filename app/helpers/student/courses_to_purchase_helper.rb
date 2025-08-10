module Student::CoursesToPurchaseHelper
  def process_course_purchase(course, user, payment_result)
    if user.purchased_courses.include?(course)
      return { 
        success: false, 
        error: "You have already purchased this course.",
        already_purchased: true
      }
    end

    payment_method = determine_payment_method(payment_result[:payment_method])

    course_purchase = user.course_purchases.build(
      course: course, 
      purchased_at: Time.current, 
      payment_method: payment_method
    )
    
    if course_purchase.save
      {
        success: true,
        course_purchase: course_purchase,
        amount: payment_result[:amount]
      }
    else
      Rails.logger.error("Failed to purchase #{course.name}: #{course_purchase.errors.full_messages.join(', ')}")
      {
        success: false,
        error: "Failed to purchase #{course.name}. Please try again."
      }
    end
  end

  private

  def determine_payment_method(payment_method_string)
    case payment_method_string
    when 'credit_card'
      CoursePurchase.payment_methods[:credit_card]
    when 'license_code'
      CoursePurchase.payment_methods[:license_code]
    else
      CoursePurchase.payment_methods[:other]
    end
  end
end
