class Student::TermsToPurchaseController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @terms = current_user.school.terms
  end
end
