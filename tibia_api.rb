require 'json'
require 'nokogiri'
require 'open-uri'
require 'sinatra'

require_relative 'app/models/world'

module TibiaAPI
  class App < Sinatra::Base
    get '/api/worlds.json' do
      content_type :json
      worlds = TibiaAPI::World.all.map(&:to_json)
      { worlds: worlds }.to_json
    end
  end
end
