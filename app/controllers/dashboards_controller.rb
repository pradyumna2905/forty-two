class DashboardsController < ApplicationController
  def show
    @entries = current_user.entries
  end
end
