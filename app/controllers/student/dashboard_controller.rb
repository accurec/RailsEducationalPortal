class Student::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @student = User.find_by(email: current_user.email)
  end
end
