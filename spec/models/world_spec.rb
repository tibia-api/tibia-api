require 'spec_helper'
require 'models/world'

describe TibiaAPI::World, :vcr do
  describe ".all" do
    subject(:worlds) { TibiaAPI::World.all }

    it "returns an array of worlds" do
      expect(worlds.count).to be >= 70
      expect(worlds.first).to be_a TibiaAPI::World
      expect(worlds.first.name).to be == 'Aldora'
    end
  end
end
