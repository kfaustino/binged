module Binged
  module Search
    class Base
      include Enumerable
      attr_reader :client, :query, :source

      BASE_URI = 'http://api.bing.net/json.aspx?'

      def initialize(client)
        @client = client
        reset_query
      end

      # Clears all filters to perform a new search
      def clear
        @fetch = nil
        reset_query
        self
      end

      def perform
        url = URI.parse BASE_URI
        query = @query.dup
        query[:Query] = query[:Query].join(' ')      
        query[:Sources] = self.source
        query_options = default_options.merge(query).to_params
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

        def reset_query
           @query = { :Query => [] }
        end
    end

  end
end
