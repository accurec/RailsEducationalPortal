class Student::DashboardController < ApplicationController
  include Student::DashboardHelper

  before_action :authenticate_user!

  def index
    @student = User.includes(
      :school,
      course_purchases: { course: :term },
      enrollments: { course: :term }
    ).find(current_user.id)
    
    @ordered_course_purchases = @student.course_purchases.order(:purchased_at)
    @ordered_enrollments = @student.enrollments.order(:enrolled_at)
    
    @course_purchases_count = @ordered_course_purchases.count
    @enrollments_count = @ordered_enrollments.count
    
    @enrollment_status = @ordered_course_purchases.each_with_object({}) do |cp, hash|
      hash[cp.course_id] = @ordered_enrollments.any? { |e| e.course_id == cp.course_id }
    end
    
    @has_course_purchases = @course_purchases_count > 0
    @has_enrollments = @enrollments_count > 0
  end

  def enroll_in_course
    authorize :dashboard, :show_student?

    course = Course.find(params[:id])
    enrollment_result = process_course_enrollment(course, current_user)
    
    if enrollment_result[:already_enrolled]
      flash[:alert] = enrollment_result[:error]
    elsif enrollment_result[:success]
      flash[:notice] = enrollment_result[:message]
    else
      flash[:alert] = enrollment_result[:error]
    end

    redirect_to student_dashboard_path
  end
end
