module Entries
  class CreateService
    def initialize(current_user, params = {})
      @current_user = current_user
      @params = params.dup
    end

    def execute
      @entry = @current_user.entries.build(@params)

      @entry.tap do |entry|
        entry.save!
      end

    rescue ActiveRecord::RecordInvalid => e
      fail(error: e.message, resource: @entry)
    rescue StandardError => e
      fail(error: e.message, resource: @entry)
    end
  end
end
