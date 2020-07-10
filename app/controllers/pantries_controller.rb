class PantriesController < ApplicationController

    get '/pantries/new' do
        if current_users_pantry(session)
            redirect '/users'
        else
            erb :'/pantries/new'
        end
    end

    post '/pantries' do
        @user = current_user(session)
        @user.pantries.create(name: params["name"], is_full: params["is_full"])
        redirect '/users'
    end







end