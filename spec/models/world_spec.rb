require 'spec_helper'
require 'models/world'

describe TibiaAPI::World, :vcr do
  describe ".all" do
    subject(:worlds) { TibiaAPI::World.all }

    it "returns an array of worlds" do
      expect(worlds).to have_at_least(70).worlds
      expect(worlds.first).to be_a TibiaAPI::World
      expect(worlds.first.name).to be == 'Aldora'
    end

    describe "each world" do
      subject(:world) { worlds.sample }

      it "has a name" do
        expect(world.name).to be_a String
      end

      describe "#online" do
        it "has a number" do
          expect(world.online).to be_an Integer
        end
      end

      it "has a location" do
        expect(world.location).to be_a String
      end

      it "has a type" do
        expect(world.type).to be_a String
      end

      it "has aadditional info" do
        expect(world.additional).to be_a String
      end
    end
  end
end
