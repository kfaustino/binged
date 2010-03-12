module Binged
  module Search
    
    # A class that encapsulated the Bing Image Search source
    class Image < Base
      include Filter
      include Pageable
      
      # @param [Binged::Client] client
      # @param [String] query The search term to be sent to Bing
      # @param [Hash] options
      def initialize(client, query=nil, options={})
        super(client, query)
        @source = :image
        per_page(20).page(1)        
      end
      
    end
    
  end
end