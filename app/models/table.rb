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

      include ActiveModel::Model
      include ActiveModel::Serializers::JSON
    end

    module ClassMethods
      def all
        response = Net::HTTP.get URI(endpoint_url)
        dom = Nokogiri::HTML.parse(response)
        results = dom.css(list_selector).map(&method(:parse_row)).compact

        if pages
          (1..pages).each do |page|
            response = Net::HTTP.get URI(endpoint_url + "&page=#{page}")
            dom = Nokogiri::HTML.parse(response)
            results.concat dom.css(list_selector).map(&method(:parse_row)).compact
          end
        end

        results
      end

      def attributes(*attrs)
        return @attributes if attrs.empty?
        @attributes = attrs

        attr_accessor *attrs

        define_method :attributes do
          values = self.class.attributes.map &method(:send)
          self.class.parse_attributes *values
        end
      end

      def parse_attributes(*values)
        raise InconsistentNumberOfArugments if values.length != attributes.length

        Hash[attributes.zip values]
      end

      def parse_row(world_row)
        row = world_row.css('td').map { |col| col.text.strip }
        return if item_filter.call(row) || row[0].nil?

        new(parse_attributes *row)
      end
    end
  end
end
