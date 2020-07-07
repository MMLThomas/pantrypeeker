class PantriesController < ApplicationController

    #takes user to their pantry
    get "/pantries" do
        @pantry = current_user(session).pantries.first
        erb :"/pantries/index"
    end

    #page for users to add items to their pantry
    get "/pantries/new" do
        @user = current_user(session)
        if @user.pantries.empty?
            @user.pantries.create(name: params["name"], is_full: params["is_full"])
        end
        erb :"/pantries/new"
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
        @grocery = Grocery.find_by_id(params[:id])
        erb :"/pantries/show"
    end
    
    #shows form to edit items in a users pantry
    get "/pantries/:id/edit" do
        @grocery =  Grocery.find_by_id(params[:id])
        erb :"/pantries/edit"
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