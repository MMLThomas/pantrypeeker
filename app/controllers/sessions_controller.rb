class SessionsController < ApplicationController

    #if user is not logged in sends them to login page, if they are redirects to their account 
    get '/login' do
        if logged_in?(session) 
            redirect "/users/:id"  
        else    
            erb :"/users/login"
        end
    end

    #verifies user information, creates a new session and sends them to their account or presents login error
    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/:id"
        else
            @error = true   #used to inform login page of incorrect password or username 
            erb :"/index"
        end 
    end

    #logs user out and redirects them to the site homepage 
    post '/logout' do
        if logged_in?(session)
            session.clear
            redirect '/'
        else
            redirect '/'
        end
    end


    
end