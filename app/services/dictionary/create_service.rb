module Dictionary
  class CreateService
    def initialize(params = {})
      @params = params.dup
    end

    def execute
      @entry = FortyTwo::Dictionary.new(@params)

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
