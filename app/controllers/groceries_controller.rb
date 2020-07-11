class GroceriesController < ApplicationController

    #takes user to their pantry
    get "/groceries" do
        if logged_in?(session)
            @pantry = current_user(session).pantries.first
            erb :"/groceries/index"
        else 
            redirect "/"
        end
    end

    #page for users to add items to their pantry
    get "/groceries/new" do
        if logged_in?(session)
            @user = current_user(session)
            erb :"/groceries/new"
        else
            redirect "/"
        end
    end

    #creates new grocery items and add to users pantry
    post "/groceries" do
        @pantry = current_users_pantry(session)
        @pantry.groceries.create(params["grocery"])
        redirect "/groceries"
    end

    #displays item from users pantry
    get "/groceries/:id" do
        not_logged_in_redirect(session)
        grocery_exist?()
        users_grocery_data_protection(session)
        @grocery = Grocery.find_by_id(params[:id])
        erb :"/groceries/show" 
    end
    
    #shows form to edit items in a users pantry
    get "/groceries/:id/edit" do
        not_logged_in_redirect(session)
        users_grocery_data_protection(session)
        @grocery =  Grocery.find_by_id(params[:id])
        erb :"/groceries/edit"
    end

    #edits grocery items and updates pantry
    patch "/groceries/:id" do
        users_grocery_data_protection(session)
        @grocery = Grocery.find_by_id(params[:id])
        @grocery.update(params["grocery"])
        redirect "/groceries/#{@grocery.id}"
    end

    #deletes items from pantry
    delete "/groceries/:id" do
        users_grocery_data_protection(session)
        Grocery.find_by_id(params[:id]).delete
        redirect "/groceries"
    end

    
end