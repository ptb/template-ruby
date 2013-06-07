require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'serve'
require 'serve/rack'

root = ::File.dirname(__FILE__)

run Rack::Cascade.new([
  Serve::RackAdapter.new(root + '/build'),
  Rack::Directory.new(root + '/build')
])
