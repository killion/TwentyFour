class Trip < ActiveRecord::Base
  attr_accessible :city, :state, :country, :latitude, :longitude, :user_id

  reverse_geocoded_by :latitude, :longitude do |trip,results|
    if geo = results.first
      trip.city = geo.city
      trip.state = geo.state
      trip.country = geo.country
    end
  end
  after_validation :reverse_geocode

  has_many :activities

  require 'viator'

  def destination
    "#{self.city}, #{self.state} #{self.country}"
  end

  def viator_results
    viator = Viator::Client.new
    destination_id = viator.closest_destination_id_from_lat_long(
      self.latitude, self.longitude)
    viator.search_products(:start_date => Date.today, :end_date => Date.tomorrow, 
      :dest_id => destination_id)
  end

  def nearest_timezone
    NearestTimeZone.to(self.latitude, self.longitude)
  end

  def next_24_hours
    next_24_hours = Array.new
    (self.created_at.to_i .. (self.created_at + 60 * 60 * 23).to_i).step(1.hour) do |hour|
      next_24_hours << Time.at(hour).in_time_zone(self.nearest_timezone)
    end
    next_24_hours
  end

  def sphere_params
    {
      :page => 1,
      :count => 1,
      :latitude => latitude,
      :longitude => longitude,
      :distance => 5
    }
  end

  def get_sphere
    connection = Faraday.new(:url => 'http://www.thesphere.com')

    response = connection.post do |request|
      request.url "/api/v3/panos/search"
      request.headers["x-sphere-api-key"] = 'a0c5c9406222c07f566e'
      request.body = sphere_params
    end
    sphere_id = JSON.parse(response.body)["data"][0]["id"]
    "http://www.thesphere.com/direct_embed/#{sphere_id}"
  end

  def city_image
    panoramio = PanoramioRb.get_panoramas_from_point [self.latitude, self.longitude]
    if panoramio
      panoramio.photos.first.photo_file_url
    else
      nil
    end
  end
end
