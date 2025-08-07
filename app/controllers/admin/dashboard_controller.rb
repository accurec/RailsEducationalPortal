class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize :dashboard, :show_admin?
  end
end
