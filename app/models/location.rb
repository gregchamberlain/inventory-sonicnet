class Location < ActiveRecord::Base

	enum category: [:customer, :tower, :vehicle, :storage]

end
