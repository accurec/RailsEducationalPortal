class Admin::DashboardController < ApplicationController
  include Admin::DashboardHelper
  
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_admin?

    @enrollment_stats = aggregate_enrollment_statistics
  end
end
