module Binged
  module Search

    # @abstract Subclass and set @source to implement a custom Searchable class
    class Base
      include Enumerable
      attr_reader :client, :query, :source

      BASE_URI = 'http://api.bing.net/json.aspx?'

      # @param [Binged::Client] client
      # @param [String] query The search term to be sent to Bing
      def initialize(client, query=nil)
        @client = client
        @callbacks = []
        reset_query
        containing(query) if query && query.strip != ''
      end

      # Add query to search
      #
      # @param [String] query The search term to be sent to Bing
      # @return [self]
      def containing(query)
        @query[:Query] << query
        self
      end

      # Clears all filters to perform a new search
      def clear
        @fetch = nil
        reset_query
        self
      end

      # Retrieve results of the web search. Limited to first 1000 results.
      #
      # @return [Hash] A hash of the results returned from Bing
      def fetch
        if @fetch.nil?
          response = perform
          @fetch = Hashie::Mash.new(response["SearchResponse"][self.source.to_s.capitalize])
        end

        @fetch
      end

      # Performs a GET call to Bing API
      #
      # @return [Hash] Hash of Bing API response
      def perform
        url = URI.parse BASE_URI
        query = @query.dup
        query[:Query] = query[:Query].join(' ')
        query[:Sources] = self.source
        callbacks.each {|callback| callback.call(query) }
        query_options = default_options.merge(query).to_param
        query_options.gsub! '%2B', '+'
        url.query = query_options
        response = Net::HTTP.get(url)
        Crack::JSON.parse(response)
      end

      # @yieldreturn [Hash] A result from a Bing query
      def each
        fetch().results.each { |r| yield r }
      end

      protected

        attr_reader :callbacks

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
