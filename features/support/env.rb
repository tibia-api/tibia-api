$:.unshift(File.dirname(__FILE__) + '/../../app')
$:.unshift(File.dirname(__FILE__) + '/../../lib')
$:.unshift(File.dirname(__FILE__))

ENV['RACK_ENV'] = 'test'

require 'tibia_api'
Bundler.require(:default, :development, :test)
require File.join(File.dirname('__FILE__'), 'spec/support/matchers')

module AppHelper
	def app
		TibiaAPI::App
	end
end

World(Rack::Test::Methods, AppHelper)
