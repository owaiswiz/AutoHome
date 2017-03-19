require  'net/http'
begin
	device_id = ARGV[0]
	argextra = ARGV[1]
	username = ARGV[2]
	password = ARGV[3]
	extra = argextra.split("andthelimit=")
	sensor_serial = extra[0]
	temperature_limit = extra[1].to_f
	while true	
		temperature_reading=`cat /sys/bus/w1/devices/#{sensor_serial}/w1_slave`
		temperature=temperature_reading.split("t=")[1].to_f/1000
		if temperature > temperature_limit
			change="enable"
		else
			change="disable"
		end
		uri = URI("http://raspberrypi.local/device/#{device_id}/state/#{change}/#{username}/#{password}")
		res = Net::HTTP.post_form(uri,'device_id' => device_id,'change' => change,username: username,password: password)
		sleep 15
	end
rescue Exception => e
	puts e
end	