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
      end

      context "iterating over results" do
      end

    end

  end
end
