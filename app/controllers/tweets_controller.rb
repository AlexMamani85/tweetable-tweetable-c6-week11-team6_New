class TweetsController < ApplicationController

  # GET	/tweets(.:format)
  def index 
    @user = User.find(params[:user_id]) if params[:user_id]
    @tweets = Tweet.all
  end

  # GET	/users/:user_id/tweets/:id(.:format)
  def show
    @tweet = Tweet.find(params[:id]) 
  end

  # GET	/tweets/new(.:format)
  def new
    @tweet=Tweet.new
  end

  # POST	/tweets(.:format)
  def create
    # replied_to = Tweet.find(params[:replied_to_id]) if params[:replied_to_id]
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    # @tweet.replied_to = replied_to unless replied_to.nil?

    if @tweet.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # POST	/tweets/:id/reply
  def reply
    p "="*30
    p params[:id]
    p tweet_params
    replied_to = Tweet.find(params[:id])
    p "="*30
    p replied_to
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.replied_to = replied_to

    p "="*30
    p @tweet
    p "="*30
    if @tweet.save
      redirect_to replied_to
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET	/tweets/:id/edit(.:format)
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  # PATCH/PUT	/tweets/:id(.:format)
  def update
    @tweet = Tweet.find(params[:id])

    if @tweet.update(tweet_params)
      redirect_to tweets_path
    else
      render :edit, status: :unprocessable_entity
    end

  end

  # DELETE	/tweets/:id(.:format)
  def destroy
    @tweet = Tweet.find(params[:id])
    redirect_to tweets_path, status: :see_other, notice: "Critic successfully destroyed"
  end

  # GET /tweets/:id/like
  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes << current_user
    redirect_to tweets_path
  end

  # GET /tweets/:id/unlike
  def unlike
    @tweet = Tweet.find(params[:id])
    @tweet.likes.delete(current_user)
    redirect_to tweets_path
  end

  private
  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:body, :replied_to)
  end
end
