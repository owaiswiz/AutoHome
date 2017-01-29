Rails.application.routes.draw do
	
	get 'register' => "users#new"
	post 'register' => "users#create"

	get 'login' => "sessions#login"
	post 'login' => "sessions#login_attempt"
	get 'logout' => "sessions#logout"
	get 'home' => "sessions#home"


	get '/' => "home#home"
	get '/main' => "home#main"

  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
