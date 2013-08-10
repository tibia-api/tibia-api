require 'bundler'
Bundler.require

require 'models/world'

module TibiaAPI
  class App < Sinatra::Base
    get '/api/worlds.json' do
      content_type :json
      worlds = TibiaAPI::World.all.map(&:to_json)
      { worlds: worlds }.to_json
    end
  end
end
