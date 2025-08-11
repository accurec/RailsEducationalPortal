module Admin::DashboardHelper
  def aggregate_enrollment_statistics
    stats = {
      schools: {},
      summary: {
        total_schools: 0,
        total_students: 0,
        total_terms: 0,
        total_courses: 0,
        total_term_enrollments: 0,
        total_course_enrollments: 0
      }
    }
    
    School.includes(:students, terms: { courses: [:enrollments, :course_purchases] }).find_each do |school|
      stats[:schools][school.id] = {
        name: school.name,
        terms: {},
        courses: {}
      }

      stats[:summary][:total_schools] += 1
      stats[:summary][:total_students] += school.students.count

      school.terms.each do |term|
        # b. Number of students enrolled per term
        term_enrollments = term.courses.map { |c| c.enrollments.map { |e| e.user_id } }.flatten.uniq.count

        stats[:schools][school.id][:terms][term.id] = {
          name: term.name,
          enrolled_students: term_enrollments
        }

        stats[:summary][:total_terms] += 1
        stats[:summary][:total_term_enrollments] += term_enrollments
        
        term.courses.each do |course|
          # a. Number of students enrolled per course
          course_enrollments = course.enrollments.count

          # c. Number of students enrolled using credit card - replacing with number of purchases with credit card
          credit_card_purchases = course.course_purchases.count { |cp| cp.payment_method == 'credit_card' }
          # d. Number of students enrolled using licenses - replacing with number of purchases with license code
          license_purchases = course.course_purchases.count { |cp| cp.payment_method == 'license_code' }

          stats[:schools][school.id][:courses][course.id] = {
            name: course.name,
            term_name: term.name,
            enrolled_students: course_enrollments,
            credit_card_purchases: credit_card_purchases,
            license_purchases: license_purchases,
            total_purchases: credit_card_purchases + license_purchases
          }

          stats[:summary][:total_courses] += 1
          stats[:summary][:total_course_enrollments] += course_enrollments
        end
      end
    end
    
    stats
  end
end
