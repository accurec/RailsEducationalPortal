class Student::DashboardController < ApplicationController
  include Student::DashboardHelper

  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @student = User.includes(
      :school,
      enrollments: {
        course: { term: :school }
      }
    ).find(current_user.id)
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
