require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "13579258"
  end
  
  #renders site homepage
  get "/" do
    if logged_in?(session)
      redirect "/users/:id"
    else
      erb :index
    end
  end



  helpers do
    #checks if user is logged in
    def logged_in?(session)
      !!session[:user_id]
    end
        
    #retrives current logged in user
    def current_user(session)
      @user = User.find_by_id(session[:user_id])
    end
  end

end
