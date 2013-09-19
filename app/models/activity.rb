class Activity < ActiveRecord::Base
  attr_accessible :title, :trip_id, :url, :time, :duration

  belongs_to :trip

  def end_time
    Chronic.parse(self.duration + " after " + self.parsed_time.to_s(:europian))
  end

  def parsed_time
    Chronic.parse(self.time).in_time_zone(self.trip.nearest_timezone)
  end
end
