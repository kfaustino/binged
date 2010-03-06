require 'spec_helper'

module Binged
  module Search

    describe "Web" do

      before(:each) do
        @client = Binged::Client.new(:api_key => 'binged')
        @search = Web.new(@client)
      end

      it "should initialize with a search term" do
        Web.new(@client, 'binged').query[:Query].should include('binged')
      end


      it "should be able to specify the number of results per page" do
        @search.per_page(10)
        @search.query['Web.Count'].should == 10
      end

      it "should be able to specify the page number" do
        @search.page(3)
        @search.query['Web.Offset'].should == @search.results_per_page * 2
      end

      it "should be able to set a file type" do
        @search.file_type(:pdf)
        @search.query['Web.FileType'].should == :pdf
      end
      

      context "fetching" do

        before(:each) do
          stub_get("http://api.bing.net/json.aspx?Web.Offset=0&Sources=Web&AppId=binged&Query=ruby&JsonType=raw&Version=2.2&Web.Count=20", 'web.json')
          @search.containing("ruby")
          @response = @search.fetch
        end

        it "should cache fetch to eliminate multiple calls to the api" do
          Web.should_not_receive(:perform)
          @search.fetch
        end

        it "should return the results of the search" do
          @response.results.size.should == @search.results_per_page
        end

        it "should support dot notation" do
          result = @response.results.first
          result.title.should == "Ruby Programming Language"
          result.description.should == "Ruby is… A dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is ..."
          result.url.should == "http://www.ruby-lang.org/en/"
        end

      end

      context "iterating over results" do

        before(:each) do
          stub_get("http://api.bing.net/json.aspx?Web.Offset=0&Sources=Web&AppId=binged&Query=ruby&JsonType=raw&Version=2.2&Web.Count=20", 'web.json')
          @search.containing("ruby")
        end

        it "should be able to iterate over results" do
          @search.respond_to?(:each).should be_true
        end

        it "should have items" do
          @search.each {|item| item.should_not be_nil }
        end

      end

    end

  end
end
