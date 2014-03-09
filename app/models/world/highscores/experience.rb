require 'models/table'

module TibiaAPI
  class World
    module Highscores
      class Experience
        include Table

        self.list_selector = '#highscores table:nth(2) tr'
        self.item_filter = ->(row) { row[0] =~ /^Rank$/ }
        self.pages = 11

        attributes :rank, :name, :level, :points

        def self.all(world)
          self.endpoint_url = "http://www.tibia.com/community/?subtopic=highscores&world=#{world.capitalize}&list=experience"
          super()
        end
      end
    end
  end
end

