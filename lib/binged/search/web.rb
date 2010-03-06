module Binged
  module Search
    class Web < Base

      def initialize(client, query=nil, options={})
        super(client)
        self.query[:Sources] = 'Web'
        containing(query) if query && query.strip != ''
      end

      def containing(query)
        self.query[:Query] = query
        self
      end

      def fetch
        if @fetch.nil?
          response = perform
          @fetch = Hashie::Mash.new(response["SearchResponse"]["Web"]) if response
        end

        @fetch || []
      end

    end
  end
end
