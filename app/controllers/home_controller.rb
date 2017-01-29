class HomeController < ApplicationController
	
	before_filter :authenticate_user, :only => [:main]
  
  def home

  end

  def main

  end
end
