class Student::CoursesToPurchaseController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @courses = Course.joins(term: :school)
                     .where(schools: { id: current_user.school_id })
                     .where.not(id: current_user.purchased_courses.select(:id))
  end

  def purchase
    authorize :dashboard, :show_student?
    
    course = Course.find(params[:id])
    
    if current_user.purchased_courses.include?(course)
      flash[:alert] = "You have already purchased this course."
      redirect_to student_courses_to_purchase_path
      return
    end

    payment_processor = ::PaymentProcessor.new(current_user)
    payment_result = payment_processor.process_course_payment(course)
    payment_method = case payment_result[:payment_method]
                     when 'credit_card'
                       CoursePurchase.payment_methods[:credit_card]
                     when 'license_code'
                       CoursePurchase.payment_methods[:license_code]
                     else
                       CoursePurchase.payment_methods[:other]
                     end

    if payment_result[:success]
      course_purchase = current_user.course_purchases.build(course: course, purchased_at: Time.current, payment_method: payment_method)
      
      if course_purchase.save
        flash[:notice] = "Successfully purchased #{course.name} for $#{payment_result[:amount]}!"
        redirect_to student_courses_to_purchase_path
      else
        flash[:alert] = "Failed to enroll in course. Please try again."
        redirect_to student_courses_to_purchase_path
      end
    else
      flash[:alert] = "Payment failed: #{payment_result[:error]}"
      redirect_to student_courses_to_purchase_path
    end
  end
end
