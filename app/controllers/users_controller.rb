require 'pry'
class UsersController < ApplicationController

    get "/signup" do
        if logged_in?
            redirect "/tweets"
        else
            erb :"users/create_user"
        end
    end

    post "/signup" do
        arr = []
        username = params[:username]
        arr << username
        email = params[:email]
        arr << email
        password = params[:password]
        arr << password
        if !arr.include?("")
            user = User.new(username: username, email: email, password: password)
            if user.authenticate(password)
                user.save
                session[:user_id] = user.id
                redirect "/tweets"
            end
        else
            redirect "/signup"
        end
    end

    get "/login" do
        if logged_in?
            redirect "/tweets"
        else
            erb :"users/login"
        end
    end

    post "/login" do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])

            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

    get "/logout" do
        session.clear
        redirect "/login"
    end

    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :"users/slug"
    end

end
