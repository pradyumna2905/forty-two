module FortyTwo
  class DictionaryAdapter
    class << self
      def fetch_entry(word)
        entry = FortyTwo::Dictionary.find_by(
          word: word
        )

        return entry if entry

        entry = fetch_from_oxford(word)
        parse_entry(entry)
      end

      private

      # Fetches entry from the Oxford API and saves to FortyTwo::Dictionary
      # (internal cache)
      def fetch_from_oxford(word)
        response = FortyTwo::OxfordDictionary::Client.fetch_entry(word)

        if response[:status] == 200
          ::Dictionary::CreateService.new(
            {word: word, response: response[:data]}
          ).execute
        end
      end

      def parse_entry(entry)
        # Construct data structure
        entry_params = {}

        # Add the word in entry_params
        entry_params[:word] = entry.word
        entry_params[:records] = records_parser(entry.response)

        entry_params
      end

      # This is just horrible. O(n^5). I understand. But that is the worst
      # case.
      #
      # A lot of the iterations will have only 1 loop, so keeping this and
      # moving along.
      #
      # TODO: Fix fix fix. At least find a better way than recursive iteration.
      def records_parser(response)
        records = []

        response.results.each do |result|
          result.lexical_entries.each do |lexical_entry|
            lexical_entry.entries.each do |entry|
              entry.senses.each do |sense|
                record_params = FortyTwo::RecordParams.new

                # First store the definitions
                sense.definitions.each do |definition|
                  record_params.definitions << definition
                end

                # Then store the examples
                sense.examples.each do |example|
                  record_params.examples << example.text
                end

                records << record_params
              end
            end
          end
        end

        records
      end
    end
  end
end
