class SearchController < ApplicationController
  def show
    search = SearchService.new(current_user, params)
    meaning = search.meaning
  end
end
