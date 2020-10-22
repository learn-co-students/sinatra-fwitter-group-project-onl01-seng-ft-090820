class TweetsController < ApplicationController

    get '/tweets' do 
        if logged_in?
            @tweets = Tweet.all
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
        if logged_in?
            if params[:content] == ""
              redirect "/tweets/new"
            else
              @tweet = current_user.tweets.build(content: params[:content])
              if @tweet.save
                redirect "/tweets"
              else
                redirect "/tweets/new"
              end
            end
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show_tweet'
      else        
        redirect '/login'
      end
    end

      get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && @tweet.user_id == current_user.id
          erb :'/tweets/edit_tweet'
        elsif logged_in? && @tweet.user_id != current_user.id          
          redirect '/tweets'
        else          
          redirect '/login'
        end
      end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
            if logged_in? && !params[:content].blank?
                @tweet.update(content: params[:content])
                @tweet.save

                redirect to "/tweets/#{@tweet.id}"
            else
                redirect to "/tweets/#{@tweet.id}/edit"
            end
    end
    
    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])

        if logged_in? && @tweet.user == current_user
            @tweet.destroy
            redirect "/tweets"
        else
            redirect "/login"
        end
    end
end
