class Api::UsersController < ApiController
  skip_before_action :authorize, only: %i[show likes tweets]

  # GET /profile
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  def likes
    @user = User.find(params[:id])
    @tweets = @user.tweets
    render json: @tweets
  end
  
  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets_created
    render json: @tweets
  end

end
