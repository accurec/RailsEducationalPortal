class Student::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @student = User.includes(
      :school,
      enrollments: {
        course: :term
      }
    ).find(current_user.id)
  end

  def enroll_in_course
    authorize :dashboard, :show_student?

    enrollment = Enrollment.find(params[:id])

    if enrollment.update(enrolled_at: Time.current)
      flash[:notice] = "Successfully enrolled in #{enrollment.course.name}!"
    else
      flash[:alert] = "Failed to enroll in #{enrollment.course.name}. Please try again."
    end

    redirect_to student_dashboard_path
  end
end
