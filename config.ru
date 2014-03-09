$:.unshift(File.dirname(__FILE__) + '/lib')
$:.unshift(File.dirname(__FILE__) + '/app')

require 'tibia_api'
run TibiaAPI::App
