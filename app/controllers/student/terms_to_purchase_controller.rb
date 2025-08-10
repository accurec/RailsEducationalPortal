class Student::TermsToPurchaseController < ApplicationController
  include Student::TermsToPurchaseHelper

  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @terms = Term.joins(:school)
                 .joins(:courses)
                 .where(schools: { id: current_user.school_id })
                 .where.not(id: current_user.purchased_terms.select(:id))
                 .distinct   
  end

  def purchase_with_credit_card
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

  def purchase_with_license_code
    authorize :dashboard, :show_student?

    term = Term.find(params[:term_id])
    license_code = params[:license_code]

    if current_user.purchased_terms.include?(term)
      flash[:alert] = "You have already purchased this term."
      redirect_to student_terms_to_purchase_path
      return
    end

    if license_code.blank?
      flash[:alert] = "Please enter a license code."
      redirect_to student_terms_to_purchase_path
      return
    end

    license = License.find_by(code: license_code, is_used: false)

    if license.blank?
      flash[:alert] = "Invalid license code."
      redirect_to student_terms_to_purchase_path
      return
    end

    payment_processor = ::PaymentProcessor.new(current_user)
    payment_result = payment_processor.process_term_payment(term)

    purchase_result = process_term_purchase_with_license_code(term, current_user, license, payment_result)

    if purchase_result[:already_purchased]
      flash[:alert] = purchase_result[:error]
    elsif purchase_result[:success]
      flash[:notice] = "Successfully purchased #{term.name} for $#{payment_result[:amount]}!"
    else
      flash[:alert] = purchase_result[:error]
    end
    
    redirect_to student_terms_to_purchase_path
  end
end
