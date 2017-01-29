class SessionsController < ApplicationController
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login 

  end

  def login_attempt
    authorized_user = User.authenticate(params[:username],params[:login_password])

    if authorized_user
    	session[:user_id] = authorized_user.id
      flash[:success] = "You are Logged In"
      redirect_to(action: 'main',controller: 'home')
    else
      flash[:danger] = "Invalid Username or Password"
      render "login"	
    end

  end
  
  def logout
  	session[:user_id] = nil
  	redirect_to :action => 'login'
  end


end
