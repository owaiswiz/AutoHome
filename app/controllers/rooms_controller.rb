class RoomsController < ApplicationController
	include ApplicationHelper
	
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

	def dim_scene
		change_brightness_of_room(params[:room_id],25)
	end
	
	def bright_scene
		change_brightness_of_room(params[:room_id],100)
	end

	def reading_scene
		change_brightness_of_room(params[:room_id],67)
	end 

	def room_off
		room = Room.find(params[:room_id])
		turn_off_devices_in(room)
		redirect_to "/main/#{params[:room_id]}"
	end

	def house_off
		rooms = Room.all
		rooms.each do |room|
			turn_off_devices_in(room)
		end
		redirect_to "/main"
	end

	protected

	def turn_off_devices_in(room)
		devices = room.devices
		devices.each do |device|
			if device.state == "enabled"
				clean_pins(device)
				device.update(state: "disabled")
			end
		end
	end
	def change_brightness_of_room(room_id,brightness)
		room = Room.find(room_id)
		devices = room.devices

		devices.each do |device|
			if device.state == "enabled" && device.device_type == "light"	
				set_state(device.id,brightness)
			end
		end
		redirect_to "/main/#{room_id}"
	end
	private

	def rooms_params
		params.require(:room).permit(:name)
	end
end
