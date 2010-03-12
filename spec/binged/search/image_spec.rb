require 'spec_helper'

module Binged
  module Search

    describe "Image" do
      include AnyFilter
      include AnyPageable

      before(:each) do
        @client = Binged::Client.new(:api_key => 'binged')
        @search = Image.new(@client)
      end

      it "should initialize with a search term" do
        Image.new(@client, 'binged').query[:Query].should include('binged')
      end

      context "filtering" do

        describe "size" do
          it "should filter by small images" do
            @search.small
            @search.query['Image.Filters'].should include('Size:Small')
          end

          it "should filter by medium images" do
            @search.medium
            @search.query['Image.Filters'].should include('Size:Medium')
          end

          it "should filter by large images" do
            @search.large
            @search.query['Image.Filters'].should include('Size:Large')
          end

        end

        describe "size" do

          it "should filter for images with a maximum height in pixels" do
            @search.height 100
            @search.query['Image.Filters'].should include('Size:Height:100')
          end
          
          it "should filter for images with a maximum width in pixels" do
            @search.width 150
            @search.query['Image.Filters'].should include('Size:Width:150')
          end

        end

      end

      context "fetching" do

        before(:each) do
          stub_get("http://api.bing.net/json.aspx?AppId=binged&JsonType=raw&Image.Offset=0&Image.Count=20&Sources=image&Version=2.2&Query=ruby", 'images.json')
          @search.containing("ruby")
          @response = @search.fetch
        end

        it "should cache fetch to eliminate multiple calls to the api" do
          Image.should_not_receive(:perform)
          @search.fetch
        end

        it "should return the results of the search" do
          @response.results.size.should == 20
        end

        it "should support dot notation" do
          result = @response.results.first
          result.title.should == "ruby is said to give name ... "
          result.media_url.should == "http://www.shopping.astrolozy.com/images/gems/ruby.jpg"
          result.url.should == 'http://www.shopping.astrolozy.com/gems.asp'
          result.width.should == 506
          result.height.should == 500
          result.file_size.should == 23354
          result.content_type.should == 'image/jpeg'
        end

      end

      context "iterating over results" do

        before(:each) do
          stub_get("http://api.bing.net/json.aspx?AppId=binged&JsonType=raw&Image.Offset=0&Image.Count=20&Sources=image&Version=2.2&Query=ruby", 'images.json')
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
