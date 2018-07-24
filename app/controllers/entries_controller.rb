class EntriesController < ApplicationController
  def create
  end

  def update
    @entry = Entries::UpdateService.new(current_user, update_params).add_to_digest
    respond_to do |format|
      format.js { render template: 'dashboards/add_to_digest.js.erb' }
    end
  end

  private

  def update_params
    params.permit(:id)
  end
end
