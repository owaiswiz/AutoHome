 #@@gpio = ::RPi::GPIO
 #@@gpio.set_numbering :board
 #@@pwm = RPi::GPIO::PWM
 temperature_devices = Device.where(device_type:"temperature")
 script_file = Rails.root.join('scripts','temperature_monitor.rb')
 temperature_devices.each do |temperature_device|
 	pid = spawn("/root/.rbenv/shims/ruby #{script_file} #{temperature_device.id} #{temperature_device.extra} #{User.first.username} #{User.first.password}")
 	Process.detach(pid)
 end