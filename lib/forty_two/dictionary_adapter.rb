module FortyTwo
  class DictionaryAdapter
    class << self
      def fetch_entry(word)
        entry = FortyTwo::Dictionary.find_by(
          word: word
        )

        return entry if entry

        fetch_from_oxford(word)
      end

      def fetch_meanings
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
    end
  end
end
