require 'spec_helper'
require 'models/world/highscores/experience'

describe TibiaAPI::World::Highscores::Experience, :vcr do
  describe ".all" do
    subject(:experiences) { TibiaAPI::World::Highscores::Experience.all('Luminera') }

    it "returns an array of worlds" do
      expect(experiences.count).to be == 300
      expect(experiences.first).to be_a TibiaAPI::World::Highscores::Experience
      expect(experiences.first.rank).to be == '1'
    end
  end
end
