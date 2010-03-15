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
        create_filter_callback
      end

      # Restrict images to those small in size
      # 
      # @return [self]
      def small
        filter << 'Size:Small'
        self
      end

      # Restrict images to those medium in size
      # 
      # @return [self]
      def medium
        filter << 'Size:Medium'
        self
      end

      # Restrict images to those large in size
      # @return [self]
      def large
        filter << 'Size:Large'
        self
      end

      # Restrict images to the specified height in pixels
      #
      # @param [Fixnum] pixels height in pixels
      # @return [self]
      def height(pixels)
        filter << "Size:Height:#{pixels}"
        self
      end

      # Restrict images to the specified width in pixels
      #
      # @param [Fixnum] pixels width in pixels
      # @return [self]
      def width(pixels)
        filter << "Size:Width:#{pixels}"
        self
      end

      # Restrict images to those that have a square aspect ratio
      # 
      # @return [self]
      def square
        filter << 'Aspect:Square'
        self
      end

      # Restrict images to those that have a wide aspect ratio
      # 
      # @return [self]
      def wide
        filter << 'Aspect:Wide'
        self
      end

      # Restrict images to those that have a tall aspect ratio
      # 
      # @return [self]
      def tall
        filter << 'Aspect:Tall'
        self
      end
      
      # Restrict images to those that are in color
      # 
      # @return [self]
      def color
        filter << 'Color:Color'
        self      
      end
      
      # Restrict images to those which contain photos
      # 
      # @return [self]
      def photo
        filter << 'Style:Photo'
        self
      end
      
      # Restrict images to those which contain graphics or illustrations
      # 
      # @return [self]
      def graphics
        filter << 'Style:Graphics'
        self
      end
      
      # Restrict images to those that are in black and white
      # 
      # @return [self]
      def monochrome
        filter << 'Color:Monochrome'
        self
      end
      
      # Restrict images to those which contain faces
      # 
      # @return [self]
      def face
        filter << 'Face:Face'
        self
      end
      
      # Restrict images to those which contain portraits(head and shoulders)
      # 
      # @return [self]
      def portrait
        filter << 'Face:Portrait'
        self
      end

      private

        def create_filter_callback
          @callbacks << Proc.new { |query| query['Image.Filters'] = query['Image.Filters'].join('+') if query['Image.Filters'] }
        end

        def filter
          @query['Image.Filters'] ||= []
        end

    end

  end
end
