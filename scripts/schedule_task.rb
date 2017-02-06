require  'net/http'
device_id = ARGV[0]
change = ARGV[1]
username = ARGV[2]
password = ARGV[3]
uri = URI("http://192.168.0.100:3000/device/#{device_id}/state/#{change}/#{username}/#{password}")
res = Net::HTTP.post_form(uri,'device_id' => device_id,'change' => change,username: username,password: password)
puts res.body
=begin
def clean_multicolor_pins(device)
	@@gpio.clean_up device.red_pin
	@@gpio.clean_up	device.green_pin
	@@gpio.clean_up device.blue_pin	
end

def start_pwm(pin,duty_cycle)

end
if device.multicolor != "1"
	@@gpio.setup device.pin, as: :output
	if state == "enable"
		@@gpio.set_high device.pin
		device.update(state: "enabled",brightness:100)
	else
		@@gpio.set_low device.pin
		@@gpio.clean_up device.pin
		device.update(state: "disabled")
	end

elsif device.multicolor == "1"
	@@gpio.setup device.red_pin, as: :output
	@@gpio.setup device.green_pin, as: :output
	@@gpio.setup device.blue_pin, as: :output
	clean_multicolor_pins(device)
	if device.color == "red"
		clean_multicolor_pins(device)
		@@gpio.set_low red_pin
	elsif device.color == "green"
		clean_multicolor_pins(device)
		@@gpio.set_low green_pin
	elsif device.color == "blue"
		clean_multicolor_pins(device)
		@@gpio.set_low red_pin
	elsif device.color == "yellow"
		clean_multicolor_pins(device)
		@@gpio.set_low red_pin
		@@gpio.set_low red_pin
	elsif device.color == "cyan"
		clean_multicolor_pins(device)
		@@gpio.set_low red_pin
		@@gpio.set_low red_pin
	elsif device.color == "magenta"
		clean_multicolor_pins(device)
		@@gpio.set_low red_pin
		@@gpio.set_low red_pin
	end
end
=end