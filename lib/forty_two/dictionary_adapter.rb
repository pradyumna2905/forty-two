module FortyTwo
  class DictionaryAdapter
    class << self
      def fetch_meaning(word)
        word = FortyTwo::Dictionary.find_by(
          word: word
        )
      end
    end
  end
end
