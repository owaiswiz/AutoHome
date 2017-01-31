class DevicesController < ApplicationController

	def new
		@device = Device.new


		@availablePins = [1,2,3,4,5,6]
		@availableRooms = Room.all
	end

	def create

	end

	def destroy

	end

end
