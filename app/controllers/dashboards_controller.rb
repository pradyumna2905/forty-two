class DashboardsController < ApplicationController
  def show
    @entries = FortyTwo::Dictionary.all
  end
end
