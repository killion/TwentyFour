class Activity < ActiveRecord::Base
  attr_accessible :title, :trip_id, :url, :time

  belongs_to :trip
end
