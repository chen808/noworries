class Event < ActiveRecord::Base

	# adding the following for Geocoder
	# attr_accessible :address, :latitude, :longitude

	belongs_to :user

	geocoded_by :address # takes the address and finds the long and lat
	#after_validation :geocode, :if => :address_changed? # uses google map api
	after_validation :geocode

end
