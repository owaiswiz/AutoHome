class UsersController < ApplicationController

  before_filter :save_login_state, :only => [:new, :create]

  def new
  	only_allow_if_no_user_exist and return
		@user = User.new 
  end
  
  def create
		only_allow_if_no_user_exist and return
		@user = User.new(users_params)

		if @user.save
		  flash[:success] = "You signed up successfully"
		  redirect_to main_path and return
		else
		  flash[:danger] = "Please Rectify The Form"
		end
		render "new"
  end


  private

  def only_allow_if_no_user_exist
  	if User.first != nil
  		redirect_to login_path
  	end
  end

 	def users_params
		params.require(:user).permit(:username,:password,:password_confirmation)
  end

end
