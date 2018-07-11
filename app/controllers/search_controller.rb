class SearchController < ApplicationController
  def show
    @entry = SearchService.new(current_user, params)
  end
end
