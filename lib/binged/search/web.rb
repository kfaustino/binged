module Binged
  module Search
    
    # A class that encapsulated the Bing Web Search source
    # @todo Add support for adult and market filtering
    class Web < Base
      
      SUPPORTED_FILE_TYPES = [:doc, :dwf, :feed, :htm, :html, :pdf, :ppt, :ps, :rtf, :text, :txt, :xls]

      # @param [Binged::Client] client
      # @param [String] query The search term to be sent to Bing
      # @param [Hash] options
      def initialize(client, query=nil, options={})
        super(client)
        @source = :web
        per_page(20).page(1)
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

      # Retrieve results of the web search
      # 
      # @return [Hash] A hash of the results returned from Bing
      def fetch
        if @fetch.nil?    
          response = perform
          @fetch = Hashie::Mash.new(response["SearchResponse"]["Web"])
        end

        @fetch
      end
            
      # Add filtering based on a file type
      # 
      # @example
      #   web_search.file_type(:pdf) # Isolate search to PDF files
      # 
      # @param [Symbol] type A symbol of a {SUPPORTED_FILE_TYPES}
      # @return [self]
      # @see http://msdn.microsoft.com/en-us/library/dd250876.aspx Description of all supported file types
      def file_type(type)        
        @query['Web.FileType'] = type if SUPPORTED_FILE_TYPES.include?(type)
        self
      end
      
      # Isolate search results to a specific site      
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

      # Set the page number of the results to display
      # 
      # @param [Fixnum] num The page number of the search results
      # @return [self]
      def page(num=1)
        offset = num - 1
        @query['Web.Offset'] = @results_per_page * offset
        self
      end

      # The amount of results to display per page. Initialized to 20 per page.
      # 
      # @param [Fixnum] num The number of results per page
      # @return [self]
      def per_page(num)
        @results_per_page = num
        @query['Web.Count'] = @results_per_page
        self
      end

    end
  end
end
