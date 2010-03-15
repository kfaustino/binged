require 'spec_helper'

module Binged
  module Search

    describe "Video" do
      include AnyFilter
      include AnyPageable

      before(:each) do
        @client = Binged::Client.new(:api_key => 'binged')
        @search = Video.new(@client)
      end

      it "should initialize with a search term" do
        Video.new(@client, 'ruby').query[:Query].should include('ruby')
      end

      context "sorting" do

        it "should be able to sort by date" do
          @search.sort_by(:date)
          @search.query['Video.SortBy'].should == :date
        end

        it "should be able to sort by relevance" do
          @search.sort_by(:relevance)
          @search.query['Video.SortBy'].should == :relevance
        end

        it "should ignore unsupported sort options" do
          @search.sort_by(:boring)
          @search.query['Video.SortBy'].should be_nil
        end

      end

      context "filtering" do

        describe "duration" do

          %w(Short Medium Long).each do |duration|
            it "should filter by a #{duration} duration" do
              @search.send duration.downcase.to_sym
              @search.query['Video.Filters'].should include("Duration:#{duration}")
            end
          end

        end

        describe "aspect" do

          %w(Standard Widescreen).each do |aspect|
            it "should filter by a #{aspect} aspect ratio" do
              @search.send aspect.downcase.to_sym
              @search.query['Video.Filters'].should include("Aspect:#{aspect}")
            end
          end

        end

        describe "resolution" do
          %w(Low Medium High).each do |resolution|
            it "should filter by a #{resolution} resolution" do
              @search.resolution resolution.downcase.to_sym
              @search.query['Video.Filters'].should include("Resolution:#{resolution}")
            end
          end
        end

      end

      context "fetching" do
        before(:each) do
          stub_get "http://api.bing.net/json.aspx?AppId=binged&Sources=video&JsonType=raw&Video.Count=20&Version=2.2&Query=RailsConf&Video.Offset=0", "videos.json"
          @search.containing('RailsConf')
          @response = @search.fetch
        end

        it "should cache fetch to eliminate multiple calls to the api" do
          Video.should_not_receive(:perform)
          @search.fetch
        end

        it "should return the results of the search" do
          @response.results.size.should == 20
        end

        it "should support dot notation" do
          video = @response.results.first
          video.title.should == 'RailsConf Europe 08: Jeremy Kemper (37signals), Performance on Rails'
          video.play_url.should == 'http://railsconfeurope.blip.tv/file/1555719/'
          video.source_title.should == 'blip.tv'
          video.static_thumbnail.should_not be_nil
        end

      end

      context "iterating over results" do
        
        before(:each) do
          stub_get "http://api.bing.net/json.aspx?AppId=binged&Sources=video&JsonType=raw&Video.Count=20&Version=2.2&Query=RailsConf&Video.Offset=0", "videos.json"
          @search.containing('RailsConf')
        end
        
        it "should be able to iterate through results" do
          @search.should respond_to(:each)
        end
        
        it "should have items" do
          @search.each {|result| result.should_not be_nil }
        end
        
      end

    end

  end
end
