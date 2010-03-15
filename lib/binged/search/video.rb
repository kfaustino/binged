module Binged
  module Search

    class Video < Base
      include Filter
      include Pageable

      SUPPORTED_RESOLUTIONS = [:low, :medium, :high]
      SUPPORTED_SORT_OPTIONS = [:date, :relevance]

      # @param [Binged::Client] client
      # @param [String] query The search term to be sent to Bing
      # @param [Hash] options
      def initialize(client, query=nil, options={})
        super(client, query)
        @source = :video
        set_paging_defaults
      end

      # Change the sorting of the video search
      #
      # @example
      #   search.sort_by(:date) # Return videos in chronological order
      #
      # @param [Symbol] type A symbol of a {SUPPORTED_SORT_OPTIONS}
      # @return [self]
      # @see http://msdn.microsoft.com/en-us/library/dd560945.aspx Description of all sort options
      def sort_by(type)
        @query['Video.SortBy'] = type if SUPPORTED_SORT_OPTIONS.include?(type)
        self
      end

      def short
        filter << 'Duration:Short'
        self
      end

      def medium
        filter << 'Duration:Medium'
        self
      end

      def long
        filter << 'Duration:Long'
        self
      end

      def standard
        filter << 'Aspect:Standard'
        self
      end

      def widescreen
        filter << 'Aspect:Widescreen'
        self
      end

      def resolution(type)
        filter << "Resolution:#{type.to_s.capitalize}" if SUPPORTED_RESOLUTIONS.include?(type)
        self
      end

      private

        def filter
          @query['Video.Filters'] ||= []
        end

    end

  end
end