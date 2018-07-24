module Entries
  class UpdateService
    def initialize(current_user, params = {})
      @current_user = current_user
      @params = params.dup
    end

    def add_to_digest
      @entry = @current_user.entries.find(@params[:id])

      @entry.tap do |entry|
        entry.update(saved: true)
      end
    end
  end
end
