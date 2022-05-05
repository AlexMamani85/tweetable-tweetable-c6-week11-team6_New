class TweetController < ApplicationController

  # GET	/tweets(.:format)
  def index 
    @user = User.find(params[:user_id]) if params[:user_id]
    @tweets = Tweet.all
  end


  # GET	/users/:user_id/tweets/:id(.:format)
  def show
    # @critic = Critic.find(params[:id])
    @user = User.find(params[:user_id]) if params[:user_id]
    @tweet = Tweet.find(params[:tweet_id]) if params[:tweet_id]

  end

  # GET /critics/new || /critics/new?game_id=:id || /critics/new?company_id=:id
  # GET /games/:game_id/critics/new
  # GET /company/:company_id/critics/new


  # GET	/tweets/new(.:format)
  def new
    # user02=User.create(email: 'user02@test.com', username:'user02', name:'user', password:'qwerty',password_confirmation:'qwerty')

    @tweet=Tweet.new
    

    # criticable = Game.find(params[:game_id]) if params[:game_id]
    # criticable = Company.find(params[:company_id]) if params[:company_id]
    # if criticable
    #   @critic = criticable.critics.new
    # else
    #   render "criticable"
    # end
  end

  # GET	/tweets/:id/edit(.:format)
  def edit


    

  end


  # POST /critics
  # POST /games/:game_id/critics
  # POST /company/:company_id/critics

  # POST	/tweets(.:format)
  def create
    criticable = Game.find(params[:game_id]) if params[:game_id]
    criticable = Company.find(params[:company_id]) if params[:company_id]

    @critic = criticable.critics.new(critic_params)
    @critic.criticable = criticable
    @critic.user = current_user

    if @critic.save
      redirect_to critic_path(criticable)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH	/tweets/:id(.:format)
  def update
    @critic = Critic.find(params[:id])

    if @critic.update(critic_params)
      redirect_to @critic
    else
      render :edit, status: :unprocessable_entity
    end

    if params[:replied_to_id]
      @tweet=Tweet.update(body:params[:body],user:params[:user_id], replied_to_id:params[:replied_to_id]) 
    else
      @tweet=Tweet.update(body:params[:body],user:params[:user_id]) if params[:user_id]
    end

  end

  # DELETE	/tweets/:id(.:format)
  def destroy
    @critic = Critic.find(params[:id])
    criticable = @critic.criticable
    # authorize @critic
    @critic.destroy
    redirect_to critic_path(criticable), status: :see_other, notice: "Critic successfully destroyed"
  end

  private

  # Only allow a list of trusted parameters through.
  def critic_params
    params.require(:critic).permit(:body, :replied_to,:user_id)
  end
end
