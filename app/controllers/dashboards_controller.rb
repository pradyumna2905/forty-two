class DashboardsController < ApplicationController
  def show
    @entries = current_user.entries.desc
  end
end
