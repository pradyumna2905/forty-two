class DashboardsController < ApplicationController
  def show
    @entries = current_user.entries.order(created_at: :desc)
  end
end
