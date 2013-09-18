class Trip < ActiveRecord::Base
  attr_accessible :destination, :latitude, :longitude, :user_id
  require 'viator'

  def viator_results
    viator = Viator::Client.new
    destination_id = viator.closest_destination_id_from_lat_long(
      self.latitude, self.longitude)
    viator.search_products(:start_date => Date.today, :end_date => Date.tomorrow, 
      :dest_id => destination_id)
  end
end
