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
        set_paging_defaults
      end

      # Restict images to those small in size
      def small
        filter << 'Size:Small'
      end

      # Restict images to those medium in size
      def medium
        filter << 'Size:Medium'
      end

      # Restrict images to those large in size
      def large
        filter << 'Size:Large'
      end

      # Restrict images to the specified height in pixels
      # 
      # @params [Fixnum] pixels height in pixels      
      def height(pixels)
        filter << "Size:Height:#{pixels}"
      end

      # Restrict images to the specified width in pixels
      # 
      # @params [Fixnum] pixels width in pixels
      def width(pixels)
        filter << "Size:Width:#{pixels}"
      end

      private

        def filter
          @query['Image.Filters'] ||= []
        end

    end

  end
end
