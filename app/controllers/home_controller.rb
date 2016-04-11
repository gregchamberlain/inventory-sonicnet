class HomeController < ApplicationController

	def index
		@storages = Location.storage
		@vehicles = Location.vehicle
	end

end
