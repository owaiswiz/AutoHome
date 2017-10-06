# AutoHome

A simple Ruby on Rails application to control the GPIO pins of the Raspberry Pi, using a user-friendly web interface.


### Devices 
The devices which need to be controlled should be first connected to the Raspberry Pi and then it should be added to the application via "Add a Device" page. Make sure to select the proper pin no. There are some predefined types of devices like - LED Lights,Fans, Fire Alarms which support custom operations on them such as
* LED Lights - Change Brightness ( uses PWM ), Change Color ( If light is RGB )
* Fans - Change Speed ( uses PWM )
* Fire Alarms - Requires a Thermal sensor to be connected to one pin and a buzzer to be connected to another. When the temperature crosses the specified threshold, the buzzer is switched on, until manually disabled.
 
Other than turning a device on and off, there is also the possibility to schedule the device to turn on or off at certain desired times. This is implemented by create cron jobs to turn the device on or off at the specified date and time. 
Other type of devices can also be connected, though they will only support on/off and scheduling operations.

### Rooms
One can group the devices connected by room, and then also change the scene of the room to one of the many predefined modes ( reading - lights will be dim; bright - lights will be at 100% brightness; etc ).
There is also an option to switch off all the devices in the room, and also to switch off all the devies in all the rooms.

### How to Run
1) Download the application on a Raspberry Pi, with GPIO access enabled
2) Ensure it has Ruby (2.3.1+)
3) Initially Run - `bundle install`
4) Start the server - `rails s` or use - `rails server -p 80` to run on port 80
5) Access the user interface on the ip address assigned to the Raspberry Pi and on the port specified
