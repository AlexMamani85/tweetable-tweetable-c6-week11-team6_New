class TweetsController < ApplicationController

  # GET	/tweets(.:format)
  def index 
    if params[:user_id]
      @user = User.find(params[:user_id])
      @tweets = @user.tweets_created
    else
      @tweets = Tweet.all
    end
  end

  # GET	/users/:user_id/tweets/:id(.:format)
  def show
    @tweet = Tweet.find(params[:id]) 
  end

  # GET	/tweets/new(.:format)
  def new
    @tweet=Tweet.new
    authorize @tweet
  end

  # POST	/tweets(.:format)
  def create
    # replied_to = Tweet.find(params[:replied_to_id]) if params[:replied_to_id]
    @tweet = Tweet.new(tweet_params)
    authorize @tweet
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
    replied_to = Tweet.find(params[:id])
    @tweet = Tweet.new(tweet_params)
    authorize @tweet
    @tweet.user = current_user
    @tweet.replied_to = replied_to

    if @tweet.save
      redirect_to replied_to
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET	/tweets/:id/edit(.:format)
  def edit
    @tweet = Tweet.find(params[:id])
    authorize @tweet
  end
  
  # PATCH/PUT	/tweets/:id(.:format)
  def update
    @tweet = Tweet.find(params[:id])
    authorize @tweet
    if @tweet.update(tweet_params)
      redirect_to tweets_path
    else
      render :edit, status: :unprocessable_entity
    end

  end

  # DELETE	/tweets/:id(.:format)
  def destroy
    @tweet = Tweet.find(params[:id])
    authorize @tweet
    @tweet.destroy
    redirect_to tweets_path, status: :see_other, notice: "Tweet successfully destroyed"
  end

  # GET /tweets/:id/like
  def like
    @tweet = Tweet.find(params[:id])
    authorize @tweet, :create?
    @tweet.users << current_user
    redirect_to tweet_path
  end

  # GET /tweets/:id/unlike
  def unlike
    @tweet = Tweet.find(params[:id])
    authorize @tweet, :create?
    @tweet.users.delete(current_user)
    redirect_to tweet_path
  end

  private
  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:body, :replied_to)
  end
end
