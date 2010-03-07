module Binged

  # A client which encapsulates the Bing API
  class Client

    attr_accessor :api_key

    # @param [Hash] options the options to create a client with.
    # @option options [String] :api_key The Bing API key used to make all API calls.
    def initialize(options = {})
      @api_key = options[:api_key] || Binged.api_key
    end

    # Create a web search through Bing
    # 
    # @param [String] query The search term to be sent to Bing
    def web(query='')
      Search::Web.new(self,query)
    end

  end

end
