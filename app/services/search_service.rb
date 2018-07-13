class SearchService
  def initialize(current_user, params = {})
    @current_user = current_user
    @params = params.dup
  end

  def entry
    search_from_user_entries || search_entry
  end

  private

  def search_from_user_entries
    @current_user.entries.find_by(word: @params[:w].downcase)
  end

  def search_entry
    entry = FortyTwo::DictionaryAdapter.fetch_entry(@params[:w])
    Entries::CreateService.new(@current_user, entry).execute
  end
end
