class HomeController < ApplicationController
	
	before_filter :authenticate_user, :only => [:main]
  
  def home

  end

  def main
  	@rooms = Room.all
  	begin
  		@currentRoom = Room.find(params[:currentRoomId])
  	rescue Exception => e
  		@currentRoom = Room.first
  	end
  end
end
