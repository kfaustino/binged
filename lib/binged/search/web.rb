module Binged
  module Search

    # A class that encapsulated the Bing Web Search source
    # @todo Add support for adult and market filtering
    class Web < Base
      include Filter
      include Pageable

      SUPPORTED_FILE_TYPES = [:doc, :dwf, :feed, :htm, :html, :pdf, :ppt, :ps, :rtf, :text, :txt, :xls]

      # @param [Binged::Client] client
      # @param [String] query The search term to be sent to Bing
      # @param [Hash] options
      def initialize(client, query=nil, options={})
        super(client, query)
        @source = :web
        set_paging_defaults
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

    end
  end
end
