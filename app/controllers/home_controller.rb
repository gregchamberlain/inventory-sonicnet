class HomeController < ApplicationController

	def index
		@storages = Location.storage
		@vehicles = Location.vehicle
		@orders = Order.all.order("created_at DESC")
	end

end
