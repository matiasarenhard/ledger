class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @dashboard = DashboardService.new(current_user).call
  end
end
