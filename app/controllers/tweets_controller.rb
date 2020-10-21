class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?
            @tweets = current_user.tweets
            erb :'tweets/tweets'
          else
            redirect to '/login'
          end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new'
          else
            redirect to '/login'
          end
    end

    post '/tweets' do
        @tweet = Tweet.new
        @tweets = Tweet.all
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = current_user.tweets.find_by(params)
            erb :'tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        erb :edit_tweet
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.update(params[:tweet])
        redirect '/tweets/#{@tweet.id}'
    end


end
