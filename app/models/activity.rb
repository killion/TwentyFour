class Activity < ActiveRecord::Base
  attr_accessible :title, :trip_id

  belongs_to :trip
end
