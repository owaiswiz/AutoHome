class RoomsController < ApplicationController
	
	before_filter :authenticate_user

	def new
		@room = Room.new
	end

	def create
		@room = Room.new(rooms_params)

		if @room.save
			flash[:success] = "Room was Added"
			redirect_to main_path and return
		else
			flash[:danger] = "An Unknow Error Occurred"
		end
		render new_room_path
	end

	private

	def rooms_params
		params.require(:room).permit(:name)
	end
end
