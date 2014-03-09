require 'models/table'

module TibiaAPI
  class World
    include Table

    attributes :name, :online, :location, :type, :additional

    self.endpoint_url = 'http://www.tibia.com/community/?subtopic=worlds'
    self.list_selector = '#worlds table.TableContent tr'
    self.item_filter = ->(row) { row[0] =~ /(^Overall Maximum|^World$)/ }
  end
end
