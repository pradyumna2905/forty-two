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
        entry_params[:definitions] = definitions_parser(entry.response)

        entry_params
      end

      # This is just horrible. O(n^5). I understand. But that is the worst
      # case.
      #
      # A lot of the iterations will have only 1 loop, so keeping this and
      # moving along.
      #
      # TODO: Fix fix fix. At least find a better way than recursive iteration.
      def definitions_parser(response)
        definitions = []
        response['results'].each do |result|
          result['lexical_entries'].each do |lexical_entry|
            lexical_entry['entries'].each do |entry|
              entry['senses'].each do |sense|
                sense['definitions'].each do |definition|
                  definitions << definition
                end
              end
            end
          end
        end

        definitions
      end
    end
  end
end
