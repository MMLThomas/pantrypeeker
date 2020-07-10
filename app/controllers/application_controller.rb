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
      redirect "/users"
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

    #validates user is logged and if no redirects
    def not_logged_in_redirect(session)
        if !logged_in?(session)
          redirect '/'
        end
    end

    #prohibts anyone else from editing a users data
    def users_grocery_data_protection(session)
      if current_users_pantry(session).id != Grocery.find_by_id(params[:id]).pantry_id
        redirect '/groceries'
      end
    end

    def current_users_pantry(session)
      current_user(session).pantries.first
    end

    def grocery_exist?
      if !Grocery.find_by_id(params[:id])
        redirect '/groceries'
      end
    end

    def pantry_check(session)
      if !current_users_pantry(session)
        redirect 'pantries/new'
      else
        false
      end
    end

  end

end
