class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_dashboard_path
      elsif current_user.student?
        redirect_to student_dashboard_path
      else
        redirect_to root_path
      end
    end
  end
end
