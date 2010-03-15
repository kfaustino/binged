module Binged
  # A module containing Bing search sources
  module Search

    autoload :Base, "binged/search/base"
    autoload :Web, "binged/search/web"
    autoload :Image, "binged/search/image"
    autoload :Video, "binged/search/video"

    module Pageable
      
      # Set the page number of the results to display
      #
      # @param [Fixnum] num The page number of the search results
      # @return [self]
      def page(num=1)
        @offset = num - 1
        @query["#{@source.to_s.capitalize}.Offset"] = @results_per_page * @offset
        self
      end

      # The amount of results to display per page. Initialized to 20 per page.
      #
      # @param [Fixnum] num The number of results per page
      # @return [self]
      def per_page(num)
        @results_per_page = num
        @query["#{@source.to_s.capitalize}.Count"] = @results_per_page
        self
      end
      
      protected
      
        def set_paging_defaults
          self.per_page(20).page(1)
        end
      
    end
    
    module Filter
      
      # # Isolate search results to a specific site
      #
      # @example
      #   web_search.from_site('www.ruby-lang.org')
      #
      # @param [String] site Web site address to limit search results to
      # @return [self]
      def from_site(site)
        @query[:Query] << "site:#{site}"
        self
      end
      
    end
    
  end
end
