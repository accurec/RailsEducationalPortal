class Student::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_student?

    @student = current_user
  end
end
