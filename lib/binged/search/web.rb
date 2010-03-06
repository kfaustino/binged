module Binged
  module Search
    class Web < Base

      SupportedFileTypes = [:doc, :dwf, :feed, :htm, :html, :pdf, :ppt, :ps, :rtf, :text, :txt, :xls]

      attr_reader :results_per_page, :page_number

      def initialize(client, query=nil, options={})
        super(client)
        @query[:Sources] = 'Web'
        per_page(20).page(1)
        containing(query) if query && query.strip != ''
      end

      def containing(query)
        @query[:Query] = query
        self
      end

      def fetch
        if @fetch.nil?
          response = perform
          @fetch = Hashie::Mash.new(response["SearchResponse"]["Web"]) if response
        end

        @fetch || []
      end
      
      def file_type(type)        
        @query['Web.FileType'] = type if SupportedFileTypes.include?(type)
        self
      end

      # The page of the results to fetch
      def page(num=1)
        offset = num - 1
        @query['Web.Offset'] = results_per_page * offset
        self
      end

      # The amount of results to display per page
      def per_page(num)
        @results_per_page = num
        @query['Web.Count'] = results_per_page
        self
      end

    end
  end
end
