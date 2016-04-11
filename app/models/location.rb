class Location < ActiveRecord::Base

	enum category: [:customer, :tower, :vehicle, :storage, :vendor]

	has_many :item_stocks

end
