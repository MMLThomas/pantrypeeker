class PantriesController < ApplicationController

    #takes user to their pantry
    get "/pantries" do
        if logged_in?(session)
            @pantry = current_user(session).pantries.first
            erb :"/pantries/index"
        else 
            redirect "/"
        end
    end

    #page for users to add items to their pantry
    get "/pantries/new" do
        if logged_in?(session)
            @user = current_user(session)
            if @user.pantries.empty? && params["name"]
                @user.pantries.create(name: params["name"], is_full: params["is_full"])
            end
            erb :"/pantries/new"
        else
            redirect "/"
        end
    end

    #creates new grocery items and add to users pantry
    post "/pantries" do
        params.delete("add")
        @pantry = current_user(session).pantries.first
        @pantry.groceries.create(params)
        redirect "/pantries"
    end

    #displays item from users pantry
    get "/pantries/:id" do
        if logged_in?(session)
            @grocery = Grocery.find_by_id(params[:id])
            erb :"/pantries/show"
        else
            redirect "/"
        end        
    end
    
    #shows form to edit items in a users pantry
    get "/pantries/:id/edit" do
        if logged_in?(session)
            @grocery =  Grocery.find_by_id(params[:id])
            erb :"/pantries/edit"
        else
            redirect "/"
        end
    end

    #edits grocery items and updates pantry
    patch "/pantries/:id" do
        params.delete("_method")
        params.delete("edit")
        @grocery = Grocery.find_by_id(params[:id])
        @grocery.update(params)
        redirect "/pantries/#{@grocery.id}"
    end

    #deletes items from pantry
    delete "/pantries/:id" do
        Grocery.find_by_id(params[:id]).delete
        redirect "/pantries"
    end

    
end