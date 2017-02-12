require  'net/http'
device_id = ARGV[0]
change = ARGV[1]
username = ARGV[2]
password = ARGV[3]
uri = URI("http://raspberrypi.local/device/#{device_id}/state/#{change}/#{username}/#{password}")
res = Net::HTTP.post_form(uri,'device_id' => device_id,'change' => change,username: username,password: password)