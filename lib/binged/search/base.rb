module Binged
  module Search
    
    # @abstract Subclass and override {#fetch} to implement a custom Searchable class
    class Base
      include Enumerable
      attr_reader :client, :query, :source

      BASE_URI = 'http://api.bing.net/json.aspx?'

      # @param [Binged::Client] client
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
      
      def fetch
      end

      # Performs a GET call to Bing API
      # 
      # @return [Hash] Hash of Bing API response
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

      # @yieldreturn [Hash] A result from a Bing query
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
