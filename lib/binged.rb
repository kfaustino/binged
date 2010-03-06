require 'crack'
require 'hashie'
require 'net/http'
require 'uri'

Hash.send :include, Hashie::HashExtensions
require 'binged/hashie_extensions'

module Binged
  autoload :Client, "binged/client"
  autoload :Search, "binged/search"

  def self.configure
    yield self
    true
  end

  class << self
    attr_accessor :api_key
  end

end


