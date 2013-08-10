$:.unshift(File.dirname(__FILE__) + '/lib')

require 'tibia_api'
run TibiaAPI::App
