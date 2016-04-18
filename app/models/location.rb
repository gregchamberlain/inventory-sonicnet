class Location < ActiveRecord::Base

	enum category: [:customer, :tower, :vehicle, :storage, :vendor]

	has_many :item_stocks

	def orders
		Order.where(["to_location = ? OR from_location = ?", self.id, self.id]).order("created_at DESC")
	end

end
