module FortyTwo::OxfordDictionary
  module Request
    # Keys
    APP_ID = ENV.fetch('APP_ID') { '76b1795b' }
    APP_KEY = ENV.fetch('APP_KEY') { 'f3b8453976f23d32db09cd39d7b1bd76' }

    # Constants
    BASE = 'https://od-api.oxforddictionaries.com/api/v1'.freeze
    HTTP_OK = 200
    NOT_FOUND = 404
    ACCEPT_TYPE = 'application/json'.freeze

    # Endpoints

    # Support only EN for now
    ENTRY_ENDPOINT = 'entries/en'.freeze

    # Requests
    def entry_request(word)
      request(ENTRY_ENDPOINT, word)
    end

    private

    def request(endpoint, query)
      if APP_ID.blank? || APP_KEY.blank?
        raise "Please set ENV['APP_ID'] and ENV['APP_KEY']"
      end

      response = HTTParty.get(
        build_url(endpoint, query),
        { headers: headers }
      )

      parse_response_or_raise(response)
    end

    def build_url(endpoint, query)
      "#{BASE}/#{endpoint}/#{query}".chomp('/')
    end

    def headers
      {
        'Accept': ACCEPT_TYPE,
        'app_id': APP_ID,
        'app_key': APP_KEY
      }
    end

    def parse_response_or_raise(response)
      if response.code == NOT_FOUND
        { status: response.code, data: [] }
      elsif response.code == HTTP_OK
        { status: response.code, data: JSON.parse(response.body).to_snake_keys }
      else
        raise('Something went wrong')
      end
    end
  end
end
