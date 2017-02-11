class DevicesController < ApplicationController
	include ApplicationHelper
	skip_before_action :verify_authenticity_token, :only => [:change_state]
	before_action :authenticate_user, :except => [:change_state]
	def new
		@device = Device.new

		@devices = Device.all

		@availablePins = [7,8,10,11,12,13,15,16,18,19,21,22,23,24,26,27,28,29,31,32,33,35,36,37,38,40]

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
				if @device.multicolor=="1"
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

	def change_state
		if !session[:user_id]
			if !(params[:username] == User.first.username && params[:password] == User.first.password)
				return false
			end
		end
		device_id = params[:device_id]
		change = params[:change]
		device = Device.find(device_id)	
		if change == "enable"
			if device.device_type == "light" or device.device_type == "fan"
				set_state(device_id,change) 
			else
				@@gpio.setup device.pin,as: :output
				@@gpio.set_high device.pin
				device.update(state: "enabled")
			end
		else
			device = Device.find(device_id)	
			clean_pins(device)
			device.update(state: "disabled")
		end
	end

	def change_color
		device_id = params[:device_id]
		device = Device.find(device_id)
		color = params[:color]
		device.update(color:color)
		set_multicolor(device,device.brightness)
	end

	def change_brightness
		set_state(params[:device_id],params[:brightness])
	end

	def change_speed
		device_id = params[:device_id]
		speed = params[:speed].to_f * 25;
		set_state(device_id,speed)		
	end

	def schedule_device
		device_id = params[:device_id]
		schedule_type = params[:schedule_type]
		schedule_day = params[:schedule_day]
		schedule_hour = params[:schedule_hour]
		schedule_minute = params[:schedule_minute]
		schedule_state = params[:schedule_state]
		schedule_day = "*" if schedule_type == "everyday"
		username = User.first.username
		password = User.first.password
		cron_command = "#{schedule_minute} #{schedule_hour} #{schedule_day} * * /root/scheduletask.sh #{device_id} #{schedule_state} #{username} #{password}"

		`(crontab -l;echo "#{cron_command}") | crontab`
		
	end
	

	def destroy
		device = Device.find(params[:device_id])
		clean_pins(device)
		device.destroy
	end

	protected

	private
	def devices_params
		params.require(:device).permit(:name,:pin,:device_type,:color,:icon,:multicolor,:red_pin,:green_pin,:blue_pin)
	end
end
