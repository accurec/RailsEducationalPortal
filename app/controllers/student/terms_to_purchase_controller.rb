class Student::TermsToPurchaseController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @terms = Term.joins(:school)
                 .where(schools: { id: current_user.school_id })
                 .where.not(id: current_user.purchased_terms.select(:id))
  end

  def purchase
    authorize :dashboard, :show_student?

    term = Term.find(params[:id])

    if current_user.purchased_terms.include?(term)
      flash[:alert] = "You have already purchased this term."
      redirect_to student_terms_to_purchase_path
      return
    end

    payment_processor = ::PaymentProcessor.new(current_user)
    payment_result = payment_processor.process_term_payment(term)
    payment_method = case payment_result[:payment_method]
                     when 'credit_card'
                       TermPurchase.payment_methods[:credit_card]
                     when 'license_code'
                       TermPurchase.payment_methods[:license_code]
                     else
                       TermPurchase.payment_methods[:other]
                     end

    if payment_result[:success]
      begin
        ActiveRecord::Base.transaction do
          term_purchase = current_user.term_purchases.build(
            term: term, 
            purchased_at: Time.current, 
            payment_method: payment_method
          )

          term_purchase.save!

          unpurchased_courses = term.courses.where.not(
            id: current_user.purchased_courses.select(:id)
          )
          unpurchased_courses_count = unpurchased_courses.count
          
          unpurchased_courses.each do |course|
            course_purchase = current_user.course_purchases.build(
              course: course,
              purchased_at: Time.current,
              payment_method: payment_method
            )

            course_purchase.save!
          end

          flash[:notice] = "Successfully purchased #{term.name} for $#{payment_result[:amount]}! Added #{unpurchased_courses_count} new courses to your account."
          redirect_to student_terms_to_purchase_path
        end
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error("Failed to purchase #{term.name}: #{e.message}")
        
        flash[:alert] = "Failed to purchase #{term.name}. Please try again."
        redirect_to student_terms_to_purchase_path
      end
    else
      flash[:alert] = "Payment failed: #{payment_result[:error]}"
      redirect_to student_terms_to_purchase_path
    end
  end
end
