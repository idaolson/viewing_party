class MovieClient
  class << self
    def get_data(endpoint)
      parse_data(conn.get(endpoint + api_key))
    end

    def api_key
      "&api_key=#{ENV['movie_api_key']}"
    end

    def conn
      Faraday.new('https://api.themoviedb.org')
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
