$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'rspec'
require 'fakeweb'
require 'binged'

FakeWeb.allow_net_connect = false
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

def bing_url(url)
  "http://api.bing.net/json.aspx#{url}&Version=2.2&JsonType=raw&AppId=binged"
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def stub_get(url, filename, options={})
  fakeweb_options = {:response => fixture_file(filename)}.merge(options)
  FakeWeb.register_uri(:get, url, fakeweb_options)
end

