require 'net/http'
require 'nokogiri'

module TibiaAPI
  class World
    attr_reader :name, :online, :location, :type, :additional

    def initialize(name: nil, online: nil, location: nil, type: nil, additional: nil)
      @name = name
      @online = online
      @location = location
      @type = type
      @additional = additional
    end

    def to_json
      {
        name: name,
        online: online,
        location: location,
        type: type,
        additional: additional
      }
    end

    def self.all
      response = Net::HTTP.get URI('http://www.tibia.com/community/?subtopic=worlds')
      dom = Nokogiri::HTML.parse(response)

      worlds = dom.css('#worlds table.TableContent tr').map do |table_row|
        name, online, location, type, additional = table_row.css('td').map(&:text).map(&:strip)
        World.new(
          name: name,
          online: online.to_i,
          location: location,
          type: type,
          additional: additional
        )
      end

      worlds.reject do |world|
        world.name =~ /(^Overall Maximum|^World$)/
      end
    end
  end
end
