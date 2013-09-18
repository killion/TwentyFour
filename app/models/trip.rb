class Trip < ActiveRecord::Base
  attr_accessible :destination, :latitude, :longitude, :user_id
  reverse_geocoded_by :latitude, :longitude do |trip,results|
    if geo = results.first
      trip.destination = "#{geo.city}, #{geo.state} #{geo.country}"
    end
  end
  after_validation :reverse_geocode
  require 'viator'

  def viator_results
    viator = Viator::Client.new
    destination_id = viator.closest_destination_id_from_lat_long(
      self.latitude, self.longitude)
    viator.search_products(:start_date => Date.today, :end_date => Date.tomorrow, 
      :dest_id => destination_id)
  end
end
