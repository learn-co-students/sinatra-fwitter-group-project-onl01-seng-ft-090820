class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :"tweets/tweets"
        else
            redirect "/login"
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :"tweets/new"
        else
            redirect "/login"
        end
    end

    post '/tweets' do
        if params[:content] != ""
            user = current_user
            tweet = user.tweets.create(content: params[:content])
            redirect "/tweets/#{tweet.id}"
        else
            redirect "/tweets/new"
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @user = current_user
            @tweet = Tweet.find_by(id: params[:id])
            erb :"tweets/show_tweet"
        else
            redirect "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @user = current_user
            @tweet = Tweet.find_by(id: params[:id])
            if @tweet.user == @user
                erb :"tweets/edit_tweet"
            else
                redirect "/tweets/#{@tweet.id}"
            end
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do
        tweet = current_user.tweets.find_by(id: params[:id])
        if params[:content] != ""
            tweet.content = params[:content]
            tweet.save
            redirect "/tweets/#{tweet.id}"
        else
            redirect "/tweets/#{tweet.id}/edit"
        end
    end

    delete '/tweets/:id/delete' do
        if current_user.tweets.find_by(id: params[:id])
            tweet = current_user.tweets.find_by(id: params[:id])
            tweet.delete
            redirect "/tweets"
        else
            redirect "/tweets"
        end
    end

        

end
