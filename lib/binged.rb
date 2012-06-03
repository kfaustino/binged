require 'active_support/core_ext/object/to_query'
require 'json'
require 'hashie'
require 'net/http'
require 'uri'

require 'binged/hashie_extensions'

# The module that contains everything Binged related
#
# * {Binged::Client} is used to interact with the Bing API
# * {Binged::Search} contains different Bing search sources
module Binged
  autoload :Client, "binged/client"
  autoload :Search, "binged/search"

  extend self

  # Configure global options for Binged
  #
  # For example:
  #
  #     Binged.configure do |config|
  #       config.api_key = 'api_key'
  #     end
  attr_accessor :api_key

  def configure
    yield self
    true
  end

end
