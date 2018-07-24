module Entries
  class CreateService
    def initialize(current_user, params = {})
      @current_user = current_user
      @params = params.dup
    end

    def execute
      @entry = @current_user.entries.build(@params.slice(:word))

      @entry.tap do |entry|
        ActiveRecord::Base.transaction do
          entry.save!

          @params.slice(:records).dig(:records).each do |record_params|
            ::Records::CreateService.new(entry, record_params).execute
          end
        end
      end

    rescue ActiveRecord::RecordInvalid => e
      fail(error: e.message, resource: @entry)
    rescue StandardError => e
      fail(error: e.message, resource: @entry)
    end
  end
end
