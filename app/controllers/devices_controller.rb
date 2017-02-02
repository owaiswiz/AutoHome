class DevicesController < ApplicationController

	def new
		@device = Device.new

		@devices = Device.all

		@availablePins = [3,5,7,8,10,11,12,13,15,16,18,19,21,22,23,24,26,27,28,29,31,32,33,35,36,37,38,40]

		@devices.each do |device|
			@availablePins -= [device.pin]
			@availablePins -= [device.red_pin]
			@availablePins -= [device.green_pin]
			@availablePins -= [device.blue_pin]
		end

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
				if @device.multicolor="1"
					@device.pin=""
				else
					@device.red_pin = ""
					@device.green_pin = ""
					@device.blue_pin = ""
				end
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
		params.require(:device).permit(:name,:pin,:device_type,:color,:icon,:multicolor,:red_pin,:green_pin,:blue_pin)
	end
end
