class Api::TweetsController < ApiController
  skip_before_action :authorize, only: %i[index show]

  # GET	/tweets(.:format)
  def index 
    if params[:user_id]
      @user = User.find(params[:user_id])
      @tweets = @user.tweets_created
    else
      @tweets = Tweet.all
    end
    render json: @tweets
  end

  # GET	/users/:user_id/tweets/:id(.:format)
  def show
    @tweet = Tweet.find(params[:id]) 
    render json: @tweet
  end

  # GET	/tweets/new(.:format)
  def new
    @tweet=Tweet.new
    # authorize @tweet
    render json: @tweet
  end

  # POST	/tweets(.:format)
  def create
    @tweet = Tweet.new(tweet_params)

    # authorize @tweet
    @tweet.user = current_user

    if @tweet.save
      render json: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  # POST	/tweets/:id/reply
  def reply
    replied_to = Tweet.find(params[:id])
    @tweet = Tweet.new(tweet_params)
    # authorize @tweet
    @tweet.user = current_user
    @tweet.replied_to = replied_to

    if @tweet.save
      render json: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  # GET	/tweets/:id/edit(.:format)
  def edit
    @tweet = Tweet.find(params[:id])
    # authorize @tweet
  end
  
  # PATCH/PUT	/tweets/:id(.:format)
  def update
    @tweet = Tweet.find(params[:id])
    if (@tweet.user == current_user) || (current_user.admin?)
      # authorize @tweet
      if @tweet.update(tweet_params)
        render json: @tweet
      else
        render json: @tweet.errors, status: :unprocessable_entity
      end
    else
      respond_unauthorized('Access denied')    
    end
  end

  # DELETE	/tweets/:id(.:format)
  def destroy
    @tweet = Tweet.find(params[:id])
    if (@tweet.user == current_user) || (current_user.admin?)
      # authorize @tweet
      @tweet.destroy
      render json: {}, status: :see_other
    else
      respond_unauthorized('Access denied')    
    end
  end

  # GET /tweets/:id/like
  def like
    @tweet = Tweet.find(params[:id])
    # authorize @tweet, :create?
    @tweet.users << current_user
    render json: @tweet
  end

  # GET /tweets/:id/unlike
  def unlike
    @tweet = Tweet.find(params[:id])
    # authorize @tweet, :create?
    @tweet.users.delete(current_user)
    render json: @tweet
  end

  private
  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:body, :replied_to)
  end
end