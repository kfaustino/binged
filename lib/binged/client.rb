module Binged
  
  class Client
    
    attr_accessor :api_key
    
    def initialize(options = {})
      @api_key = options[:api_key] || Binged.api_key
    end
        
  end
  
end