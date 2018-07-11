class SearchService
  def initialize(current_user, params = {})
    @current_user = current_user
    @params = params.dup
  end
end
