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
        
      end

      context "fetching" do
      end

      context "iterating over results" do
      end

    end

  end
end
