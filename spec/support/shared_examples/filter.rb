share_as :AnyFilter do

  it "should be able to specify a site to limit searches to" do
    @search.from_site('adventuresincoding.com')
    @search.query[:Query].should include('site:adventuresincoding.com')
  end

end
