module Student::DashboardHelper
  def process_course_enrollment(course, user)
    existing_enrollment = user.enrollments.find_by(course: course)
    
    if existing_enrollment
      return {
        success: false,
        error: "You are already enrolled in #{course.name}!",
        already_enrolled: true
      }
    end

    enrollment = Enrollment.new(
      course: course, 
      user: user, 
      enrolled_at: Time.current
    )
    
    if enrollment.save
      {
        success: true,
        enrollment: enrollment,
        message: "Successfully enrolled in #{course.name}!"
      }
    else
      {
        success: false,
        error: "Failed to enroll in #{course.name}. Please try again."
      }
    end
  end
end
