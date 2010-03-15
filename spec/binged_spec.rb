require 'spec_helper'

describe "Binged" do

  it "should configure the api_key for easy access" do
    Binged.configure do |config|
      config.api_key = 'api_key'
    end

    client = Binged::Client.new
    client.api_key.should == 'api_key'
  end

  describe "Flexible interface" do
    
    before(:each) do
      @client = Binged::Client.new
    end

    it "should provide an interface to web search" do
      @client.web.should be_instance_of(Binged::Search::Web)
    end

    it "should provide an interface to image search" do
      @client.image.should be_instance_of(Binged::Search::Image)
    end
    
  end

end
