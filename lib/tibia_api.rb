require 'bundler'
Bundler.require

require 'models/world'
require 'models/world/highscores/experience'

module TibiaAPI
  class App < Sinatra::Base
    get '/api/worlds.json' do
      content_type :json
      worlds = TibiaAPI::World.all.map(&:as_json)
      { worlds: worlds }.to_json
    end

    get '/api/worlds/:world/highscores/experiences.json' do
      content_type :json
      experiences = TibiaAPI::World::Highscores::Experience.all(params[:world]).map(&:as_json)
      { experiences: experiences }.to_json
    end
  end
end
