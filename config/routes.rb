Rails.application.routes.draw do
	
	get 'register' => "users#new"
	post 'register' => "users#create"

	get 'login' => "sessions#login"
	post 'login' => "sessions#login_attempt"
	get 'logout' => "sessions#logout"
	get 'home' => "sessions#home"


	get '/' => "home#home"
	get '/main' => "home#main"
	get '/main/:currentRoomId' => "home#main"

	get '/room/add' => "rooms#new"
	post '/room/add' => "rooms#create"

	get '/device/add' => "devices#new"
	post '/device/add' => "devices#create"

	post '/device/:device_id/state/:change' => "devices#change_state"
	post '/device/:device_id/state/:change/:username/:password' => "devices#change_state"
	post '/device/:device_id/color/:color' => "devices#change_color"
	post '/device/:device_id/brightness/:brightness' => "devices#change_brightness"
	post '/device/:device_id/speed/:speed' => "devices#change_speed"
	post '/device/:device_id/schedule' => "devices#schedule_device"
	post '/device/:device_id/destroy' => "devices#destroy"

	get '/room/:room_id/dim_scene' => "rooms#dim_scene"
	get '/room/:room_id/bright_scene' => "rooms#bright_scene"
	get '/room/:room_id/reading_scene' => "rooms#reading_scene"
	get '/room/:room_id/turnoff' => "rooms#room_off"
	get '/house/turnoff' => "rooms#house_off"

	get '/device/:device_id/get_temperature' => "devices#get_temperature"
	post '/device/:device_id/update_limit/:limit' => "devices#update_limit"

  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
