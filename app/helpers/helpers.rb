class Helpers

    #retrives current logged in user
    def self.current_user(session)
        @user = User.find(session[:user_id])
    end 

    #checks if user is logged in
    def self.logged_in?(session)
        !!session[:user_id]
    end

    
end