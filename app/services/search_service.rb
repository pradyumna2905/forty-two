class SearchService
  def initialize(current_user, params = {})
    @current_user = current_user
    @params = params.dup
  end

  def meaning
    FortyTwo::DictionaryAdapter.fetch_meaning(word)
  end

  private

  def word
    @word ||= @params[:w]
  end
end
