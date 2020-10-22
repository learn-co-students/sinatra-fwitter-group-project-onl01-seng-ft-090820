class UsersController < ApplicationController

    get '/' do
        erb :index
    end

    get '/signup' do
        if !logged_in?
        erb :'users/signup'
        else
        redirect '/tweets'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        else
            @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect '/tweets'
        end
    end

    post "/login" do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect '/tweets'
        else
          redirect '/signup'
        end
    end

    get "/users/:slug" do
        User.find_by_slug(params[:username])
        erb :'users/show'
    end

    get "/logout" do
        session.clear
        redirect "/login"
    end

end
