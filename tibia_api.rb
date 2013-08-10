require 'json'
require 'nokogiri'
require 'open-uri'
require 'sinatra'

require_relative 'app/models/world'

module TibiaAPI
  class App < Sinatra::Base
    get '/api/worlds.json' do
      content_type :json

      # content = open('http://tibia.com/community/?subtopic=worlds').read
      # doc = Nokogiri::HTML.parse(content)

      # require 'awesome_print'
      # ap doc.at_css('#worlds table tr td').text

      worlds = TibiaAPI::World.all.map(&:to_json)
      { worlds: worlds }.to_json
    end
  end
end
