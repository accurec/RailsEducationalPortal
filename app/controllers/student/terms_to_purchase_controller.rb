class Student::TermsToPurchaseController < ApplicationController
  include Student::TermsToPurchaseHelper

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

    if payment_result[:success]
      purchase_result = process_term_purchase(term, current_user, payment_result)
      
      if purchase_result[:success]
        flash[:notice] = "Successfully purchased #{term.name} for $#{payment_result[:amount]}! Added #{purchase_result[:courses_added]} new courses to your account."
      else
        flash[:alert] = "Failed to purchase #{term.name}. Please try again."
      end
      
      redirect_to student_terms_to_purchase_path
    else
      flash[:alert] = "Payment failed: #{payment_result[:error]}"
      redirect_to student_terms_to_purchase_path
    end
  end
end
