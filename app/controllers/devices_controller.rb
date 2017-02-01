class DevicesController < ApplicationController

	def new
		@device = Device.new


		@availablePins = [1,2,3,4,5,6]
		@availableRooms = Room.all
		if @availableRooms.empty?
			flash[:danger] = "Please Add A Room Before Adding A Device"
			redirect_to room_add_path and return
		end
	end

	def create
		begin
			@room = Room.find(params[:device][:room])
			@device = @room.devices.new(devices_params)
			@device.state = "disabled"
			
			if @device.device_type == "light"
				@device.icon = "fa-lightbulb-o"
				@device.brightness=100
			elsif @device.device_type == "fan"
				@device.color = ""
				@device.multicolor = ""
				@device.speed = 4
				@device.icon = "fa-arrows"
			else
				@device.color = ""
				@device.multicolor = ""
			end

			if @device.save
				flash[:success] = "Device was Added Successfully"
				redirect_to main_path and return
			else
				flash[:danger] = "An Unknown Error Occurred"
				render :new and return
			end

		rescue Exception => e
			puts e
			flash[:danger] = "An Unknown Error Occurred"
			redirect_to "device_add_path" and return
		end
	end

	def destroy

	end

	private
	def devices_params
		params.require(:device).permit(:name,:pin,:device_type,:color,:icon,:multicolor)
	end
end
