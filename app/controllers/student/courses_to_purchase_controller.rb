class Student::CoursesToPurchaseController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @courses = current_user.school.terms.map(&:courses).flatten
  end
end
