require 'net/http'

module TibiaAPI
  class World
    attr_reader :name, :online, :location, :type, :additional

    def initialize(options={})
      @name = options[:name]
      @online = options[:online]
      @location = options[:location]
      @type = options[:type]
      @additional = options[:additional]
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
