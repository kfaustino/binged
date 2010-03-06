require 'spec_helper'

module Binged
  module Search

    describe "Web" do

      before(:each) do
        client = Binged::Client.new(:api_key => 'binged')
        @web = Web.new(client)
      end

      it "should retrieve a list of search results based on a specific query" do
        stub_get("http://api.bing.net/json.aspx?AppId=binged&Sources=Web&Query=ruby&Version=2.2&JsonType=raw", 'web.json')
        result = @web.containing("ruby")
        result.first.title.should == "Ruby Programming Language"
      end

    end

  end
end

