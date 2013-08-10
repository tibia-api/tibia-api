ENV['RACK_ENV'] = 'test'

require File.join(File.dirname('__FILE__'), 'tibia_api')
require File.join(File.dirname('__FILE__'), 'spec/support/matchers')
require 'rspec'
require 'sinatra'
require 'rack/test'

module AppHelper
	def app
		TibiaAPI::App
	end
end

World(Rack::Test::Methods, AppHelper)
