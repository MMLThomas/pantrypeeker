class User < ActiveRecord::Base
    has_secure_password
    has_many :friendships
    has_many :friends, through: :friendships, source: :friend
    has_many :pantries
    
   def self.existing_username?(params)
    !!User.find_by(username: params[:username])
   end

   def self.passwords_match?(params)
        params["new-password"] == params["confirmed-new-password"]  
   end

   def self.emails_match?(params)
        params["email"] == params["cconfirmed-email"]
   end




    
end