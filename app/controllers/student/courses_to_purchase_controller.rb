class Student::CoursesToPurchaseController < ApplicationController
  include Student::CoursesToPurchaseHelper

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
    
    payment_processor = ::PaymentProcessor.new(current_user)
    payment_result = payment_processor.process_course_payment(course)
    
    purchase_result = process_course_purchase(course, current_user, payment_result)
    
    if purchase_result[:already_purchased]
      flash[:alert] = purchase_result[:error]
    elsif purchase_result[:success]
      flash[:notice] = "Successfully purchased #{course.name} for $#{purchase_result[:amount]}!"
    else
      flash[:alert] = purchase_result[:error]
    end
    
    redirect_to student_courses_to_purchase_path
  end
end
