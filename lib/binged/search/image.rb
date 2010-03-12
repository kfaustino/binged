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

      # Restrict images to those small in size
      def small
        filter << 'Size:Small'
      end

      # Restrict images to those medium in size
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

      # Restrict images to those that have a square aspect ratio
      def square
        filter << "Aspect:Square"
      end

      # Restrict images to those that have a wide aspect ratio
      def wide
        filter << "Aspect:Wide"
      end

      # Restrict images to those that have a tall aspect ratio
      def tall
        filter << "Aspect:Tall"
      end
      
      # Restrict images to those that are in color
      def color
        filter << "Color:Color"
      end
      
      # Restrict images to those which contain photos
      def photo
        filter << "Style:Photo"
      end
      
      # Restrict images to those which contain graphics or illustrations
      def graphics
        filter << "Style:Graphics"
      end
      
      # Restrict images to those that are in black and white
      def monochrome
        filter << "Color:Monochrome"
      end
      
      # Restrict images to those which contain faces
      def face
        filter << 'Face:Face'
      end
      
      # Restrict images to those which contain portraits(head and shoulders)
      def portrait
        filter << 'Face:Portrait'
      end

      private

        def filter
          @query['Image.Filters'] ||= []
        end

    end

  end
end
