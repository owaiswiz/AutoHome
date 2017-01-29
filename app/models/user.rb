class User < ApplicationRecord

	
	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :password, :confirmation => true #password_confirmation attr
  	validates_length_of :password, :in => 6..20, :on => :create

  	def self.authenticate(username="",password="")
  		user = User.find_by(username: username)
  		if user
  			if user.password == password
  				return user
  			end
  			return false
  		end
  	end



end
