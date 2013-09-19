class Activity < ActiveRecord::Base
  attr_accessible :title, :trip_id, :url, :time, :duration

  belongs_to :trip

  def end_time
    Chronic.parse(self.duration + " from " + self.time).in_time_zone(self.trip.nearest_timezone).beginning_of_hour
  end

  def parsed_time
    Chronic.parse(self.time).in_time_zone(self.trip.nearest_timezone)
  end
end
