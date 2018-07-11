class SearchController < ApplicationController
  def show
    @entry = SearchService.new(current_user, params).entry
  end
end
