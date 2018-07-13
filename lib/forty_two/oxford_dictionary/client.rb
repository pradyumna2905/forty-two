module FortyTwo::OxfordDictionary
  class Client
    class << self
      include FortyTwo::OxfordDictionary::Request

      def fetch_entry(word)
        entry_request(word)
      end
    end
  end
end
