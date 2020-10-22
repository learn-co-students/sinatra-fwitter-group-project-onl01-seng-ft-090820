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
          @tweet = current_user.tweets.build(content: params[:content])
            if @tweet.save
              redirect "/tweets"
            else
              redirect "/tweets/new"
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
        if logged_in?
        # @tweet = Tweet.find_by_id(params[:id])
        # if logged_in? && @tweet.user_id == current_user.id
          @tweet = current_user.tweets.find_by_id(params[:id])
          # binding.pry
          if @tweet
            erb :'/tweets/edit_tweet'
          else
            redirect '/tweets'
          end
        # elsif logged_in? && @tweet.user_id != current_user.id          
        #   redirect '/tweets'
        else          
          redirect '/login'
        end
      end

    patch '/tweets/:id' do
        # @tweet = Tweet.find(params[:id])
        #     if logged_in? && !params[:content].blank?
        #         @tweet.update(content: params[:content])
        #         @tweet.save

        #         redirect to "/tweets/#{@tweet.id}"
        #     else
        #         redirect to "/tweets/#{@tweet.id}/edit"
        #     end
        if logged_in?
          @tweet = current_user.tweets.find_by_id(params[:id])
          # binding.pry
          if @tweet
            if @tweet.update(content: params[:content])
              redirect "/tweets/#{@tweet.id}"
            else
              redirect "/tweets/#{@tweet.id}/edit"
            end
          else
            redirect '/tweets'
          end
        else
          redirect '/login'
        end
    end
    
    delete '/tweets/:id/delete' do
    #     @tweet = Tweet.find_by_id(params[:id])

    #     if logged_in? && @tweet.user == current_user
    #         @tweet.destroy
    #         redirect "/tweets"
    #     else
    #         redirect "/login"
    #     end
    # end
    if logged_in?
      @tweet = current_user.tweets.find_by_id(params[:id])
      if @tweet
        @tweet.destroy
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
end
