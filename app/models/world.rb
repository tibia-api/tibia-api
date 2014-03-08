require 'net/http'
require 'active_model'

module TibiaAPI
  class World
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON
    attr_accessor :name, :online, :location, :type, :additional

    def attributes
      {
        name: name,
        online: online,
        location: location,
        type: type,
        additional: additional
      }
    end

    class << self
      def all
        response = Net::HTTP.get URI('http://www.tibia.com/community/?subtopic=worlds')
        dom = Nokogiri::HTML.parse(response)
        dom.css('#worlds table.TableContent tr').map(&method(:parse_one)).compact
      end

      private

      def parse_one(world_row)
        name, online, location, type, additional = world_row.css('td').map(&:text).map(&:strip)
        return if name =~ /(^Overall Maximum|^World$)/

        World.new(
          name: name,
          online: online.to_i,
          location: location,
          type: type,
          additional: additional
        )
      end
    end
  end
end
