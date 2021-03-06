class UsersController < ApplicationController

    #checks if user is logged in, if they are not it sends them to signup page
    get "/signup" do
        if logged_in?(session) 
            redirect '/users'
        else
            erb :'/users/new'
        end
    end

    #creates a new user
    post "/signup" do
        if !User.existing_username?(params)
            @user = User.create(params["user"])
            session[:user_id] = @user.id
            redirect "/users"
        else 
            @username_error = "Selected Username unavailable, try again"
            erb :'/users/new'
        end
    end

    #recieves users info from form and logs them in
    get "/users" do
        if logged_in?(session)
            pantry_check(session)
            @user = current_user(session)
            @pantry = @user.pantries.first
            erb :"/users/index" 
        else
            redirect "/login"
        end
    end

    #takes user to the account edit page if logged in
    get "/users/update" do
        if logged_in?(session)
            @user= current_user(session) 
            erb :"/users/edit" 
        else
            redirect "/login"
        end
    end



    patch '/users' do
        @user = current_user(session)
        #updates users password
        if params["new-password"]
            if @user.authenticate(params["current-password"]) && User.passwords_match?(params)
                @user.password = params["new-password"]
            else
                @password_error = "Please make sure you enter correct password and passwords match"
            end
        end

        #updates users email
        if params["email"]
            if User.emails_match?(params)
                @user.email = params["email"]
            else
                @email_error = "please make sure emails match"
            end
        end

        #updates username
        if params["username"] && params["username"] != @user.username
            if !User.existing_username?(params) 
                @user.username = params["username"]
            else 
                @username_error = "Selected Username unavailable, try again"
            end
        end
        if @username_error || @password_error || @email_error
        erb :"users/edit"
        else
            @user.save
            redirect "/users/update"
        end
    end


    delete "/users" do
        User.delete(params[:id])
        session.clear
        redirect "/"
    end

    
    
end