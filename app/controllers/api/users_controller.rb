class Api::UsersController < ApiController
  # skip_before_action :authorize, only: %i[create]

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

  # def create
  #   p "="*50
  #   p user_params
  #   p "="*50 
  #   @user = User.new(user_params)
  #   if @user.save
  #     render json: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # private
  # def user_params
  #   params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  # end
end
