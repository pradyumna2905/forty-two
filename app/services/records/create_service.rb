module Records
  class CreateService
    def initialize(entry, params = {})
      @entry = entry
      @params = params.dup
    end

    def execute
      @record = @entry.records.build(
        definitions: @params.definitions,
        examples: @params.examples
      )

      @record.tap do |record|
        record.save!
      end

    rescue ActiveRecord::RecordInvalid => e
      fail(error: e.message, resource: @record)
    rescue StandardError => e
      fail(error: e.message, resource: @record)
    end
  end
end
