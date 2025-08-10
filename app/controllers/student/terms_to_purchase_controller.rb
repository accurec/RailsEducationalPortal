class Student::TermsToPurchaseController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @terms = Term.joins(:school)
                 .where(schools: { id: current_user.school_id })
                 .where.not(id: current_user.purchased_terms.select(:id))
  end
end
