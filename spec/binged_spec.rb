require 'spec_helper'

describe "Binged" do

  it "should configure the api_key for easy access" do
    Binged.configure do |config|
      config.api_key = 'api_key'
    end

    client = Binged::Client.new
    client.api_key.should == 'api_key'
  end

  it "should provide a simple interface to web search" do
    client = Binged::Client.new
    client.web.should be_instance_of(Binged::Search::Web)
  end

end
