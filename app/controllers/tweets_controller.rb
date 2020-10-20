class TweetsController < ApplicationController

    get '/tweets' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        @tweets = Tweet.all
        erb :'tweets/index'
    end

    get '/tweets/new' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        erb :'tweets/new'
    end

    post '/tweets' do
        if params[:tweet][:content] == ""
            session[:error] = "Tweet cannot be blank"
            redirect '/tweets/new'
        end
        tweet = Tweet.create(params[:tweet])
        tweet.user_id = session[:user_id]
        tweet.save

        redirect '/tweets'
    end

    get '/tweets/:id' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show'
    end

    get '/tweets/:id/edit' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        @tweet = Tweet.find(params[:id])
        erb :'tweets/edit'
    end

    patch '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if params[:tweet][:content] == ""
            session[:error] = "Tweet cannot be blank"
            redirect "/tweets/#{tweet.id}/edit"
        end
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        user = User.find(session[:user_id])
        if user == tweet.user
            tweet.update(params[:tweet])

        end
    end

    delete '/tweets/:id' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        user = User.find(session[:user_id])
        tweet = Tweet.find(params[:id])
        if user != tweet.user
            redirect "/tweets/#{tweet.id}"
        end
        Tweet.destroy(params[:id])
        redirect '/tweets'
        
    end

end