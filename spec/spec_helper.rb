$:.unshift(File.dirname(__FILE__) + '/../app')
$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))

require 'bundler'
Bundler.require(:default, :development, :test)
require 'support/vcr_setup'
