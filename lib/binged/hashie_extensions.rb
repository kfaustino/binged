# Ensures all Hash keys follow ruby idioms
# @private
module Hashie
  class Mash < Hashie::Hash
    protected
      def convert_key(key) #:nodoc:
        key.to_s.gsub(/([a-z\d])([A-Z])/,'\1_\2').
          downcase
      end
  end
end
