module Binged
  module Search
    class Base
      include Enumerable
      attr_reader :client, :query

      BASE_URI = 'http://api.bing.net/json.aspx?'

      def initialize(client)
        @client = client
        @query = {}
      end

      # Clears all filters to perform a new search
      def clear
        @fetch = nil
        @query = {}
        self
      end

      def perform
        url = URI.parse BASE_URI
        query_options = default_options.merge(self.query).to_params
        url.query = query_options
        response = Net::HTTP.get(url)
        Crack::JSON.parse(response)
      end

      def each
        fetch().results.each { |r| yield r }
      end

      private

        def default_options
          {:AppId => @client.api_key, :JsonType => 'raw', :Version => '2.2'  }
        end

    end

  end
end
