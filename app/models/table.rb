require 'net/http'
require 'active_model'
require 'active_support/concern'
require 'active_support/core_ext/class/attribute'

module TibiaAPI
  module Table
    extend ActiveSupport::Concern

    class InconsistentNumberOfArugments < StandardError; end

    included do
      class_attribute :endpoint_url, :list_selector, :item_filter, :pages
      self.pages = 1

      include ActiveModel::Model
      include ActiveModel::Serializers::JSON
    end

    def attributes
      values = self.class.attributes.map &method(:send)
      self.class.parse_attributes *values
    end

    module ClassMethods
      def all
        (0...pages).flat_map &method(:parse_page)
      end

      def attributes(*attrs)
        return @attributes if attrs.empty?
        @attributes = attrs

        attr_accessor *attributes
      end

      def parse_attributes(*values)
        raise InconsistentNumberOfArugments if values.length != attributes.length

        Hash[attributes.zip values]
      end

      def parse_page(page)
        response = Net::HTTP.get URI(endpoint_url + "&page=#{page}")
        dom = Nokogiri::HTML.parse(response)
        dom.css(list_selector).map(&method(:parse_row)).compact
      end

      def parse_row(world_row)
        row = world_row.css('td').map { |col| col.text.strip }
        return if row[0].nil? || item_filter.call(row)

        new(parse_attributes *row)
      end
    end
  end
end
