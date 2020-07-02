class FriendsController < ApplicationController

    #show friends list and friend request
    get "/friends" do
        erb :"/friends/index"
    end

    #shows a selected friends page and pantry
    get "/friends/:id" do
        erb :"/friends/show"
    end

    #form to enter username of friend you want to add
    get "/friends/new" do
        erb :"/friends/new"
    end

    #sends friend request and creates new friend object
    post "/friends" do
        
    end

    #deletes friend if user presses delete friend button
    delete "/friends" do
        ""
    end

end