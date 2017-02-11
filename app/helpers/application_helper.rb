module ApplicationHelper
	@@gpio = ::RPi::GPIO
 	@@gpio.set_numbering :board
 	@@pwm = RPi::GPIO::PWM
 	
	def set_state(device_id,change)
		device = Device.find(device_id)

		if device.multicolor == "1"
			if change == "enable"
				duty_cycle = device.brightness.to_f
			else
				duty_cycle = change.to_f
			end
			set_multicolor(device,duty_cycle)
			device.update(state:"enabled",brightness: duty_cycle)
		else		
			if change == "enable"
				if device.device_type == "light" 
					duty_cycle = device.brightness.to_f
				elsif device.device_type === "fan"
					duty_cycle = device.speed.to_f * 25
				end
			else 
				duty_cycle = change.to_f
			end
			start_pwm(device.pin,duty_cycle)
			if device.device_type == "light"
				device.update(state:"enabled",brightness: duty_cycle)	
			else
				device.update(state:"enabled",speed: duty_cycle/25)
			end
		end	
	end

	def start_pwm(pin,duty_cycle)
		@@gpio.setup pin,as: :output
		pwm = @@pwm.new(pin, 1000)
		pwm.start duty_cycle
	end


	def set_multicolor(device,duty_cycle)
		clean_pins(device)
		duty_cycle = 100 - duty_cycle
		if device.color == "red"
			start_pwm(device.red_pin,duty_cycle)
		elsif device.color == "green"
			start_pwm(device.green_pin,duty_cycle)
		elsif device.color == "blue"
			start_pwm(device.blue_pin,duty_cycle)
		elsif device.color == "yellow"
			start_pwm(device.red_pin,duty_cycle)
			start_pwm(device.green_pin,duty_cycle)	
		elsif device.color == "cyan"
			start_pwm(device.green_pin,duty_cycle)
			start_pwm(device.blue_pin,duty_cycle)
		elsif device.color == "magenta"
			start_pwm(device.red_pin,duty_cycle)
			start_pwm(device.blue_pin,duty_cycle)
		end
	end

	def clean_pins(device)
		if device.multicolor == "1"
			@@gpio.setup device.red_pin,as: :output
			@@gpio.setup device.blue_pin,as: :output
			@@gpio.setup device.green_pin,as: :output
			@@gpio.clean_up device.red_pin
			@@gpio.clean_up	device.green_pin
			@@gpio.clean_up device.blue_pin	
		else
			@@gpio.setup device.pin,as: :output
			@@gpio.clean_up device.pin
		end
	end

end
