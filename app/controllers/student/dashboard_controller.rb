class Student::DashboardController < ApplicationController
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
    existing_enrollment = current_user.enrollments.find_by(course: course)
    
    if existing_enrollment
      flash[:alert] = "You are already enrolled in #{course.name}!"
    else
      enrollment = Enrollment.new(course: course, user: current_user, enrolled_at: Time.current)
      
      if enrollment.save
        flash[:notice] = "Successfully enrolled in #{course.name}!"
      else
        flash[:alert] = "Failed to enroll in #{course.name}. Please try again."
      end
    end

    redirect_to student_dashboard_path
  end
end
