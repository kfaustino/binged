# Overview

## About Binged

A Ruby wrapper for the Bing API. DSL inspired by jnunemaker's [Twitter Gem](http://github.com/jnunemaker/twitter) Search API wrapper.

## Installation

    [sudo] gem install binged

### Get Your Bing API key

To use binged, you will require a Bing API key. Create one at: [http://www.bing.com/developers/createapp.aspx](http://www.bing.com/developers/createapp.aspx)

## Usage

### Instantiate a client
    binged = Binged::Client.new(:api_key => 'binged')
  
### Ruby on Rails
  
Binged allows for configuration to be done once using a configure block. To use binged in your Ruby on Rails project, configure it globally in an initializer.
    
    # config/initializers/binged.rb
    Binged.configure do |config|
      config.api_key = 'api_key'
    end
      
    # Client initialization
    binged = Binged::Client.new            

### Web Search Example

    # Find 30 results for ruby from site http://www.ruby-lang.org
    web_search = Binged::Client.new.web
    web_search.containing('ruby').from_site('www.ruby-lang.org').per_page(30).each {|result| pp result }

### Image Search Example

    # Find all portrait Matz images with a wide aspect ratio
    image_search = Binged::Client.new.image
    image_search.containing('Yukihiro Matsumoto').portrait.wide.each {|image| pp image}
    
## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Kevin Faustino. See LICENSE for details.
