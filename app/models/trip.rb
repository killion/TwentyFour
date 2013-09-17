class Trip < ActiveRecord::Base
  attr_accessible :destination, :latitude, :longitude, :user_id
end
