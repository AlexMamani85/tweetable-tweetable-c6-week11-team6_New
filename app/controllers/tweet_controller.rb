class TweetController < ApplicationController
  # GET /tweets
  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    @tweets = Tweet.all
  end

  # GET /critics/:id
  def show
    @critic = Critic.find(params[:id])
  end

  # GET /critics/new || /critics/new?game_id=:id || /critics/new?company_id=:id
  # GET /games/:game_id/critics/new
  # GET /company/:company_id/critics/new
  def new
    criticable = Game.find(params[:game_id]) if params[:game_id]
    criticable = Company.find(params[:company_id]) if params[:company_id]
    if criticable
      @critic = criticable.critics.new
    else
      render "criticable"
    end
  end

  # GET /critics/:id/edit
  def edit
    @critic = Critic.find(params[:id])
  end

  def approve
    @critic = Critic.find(params[:critic_id])
    criticable = @critic.criticable
    @critic.update(approved:true)
    redirect_to critic_path(criticable)

  end

  # POST /critics
  # POST /games/:game_id/critics
  # POST /company/:company_id/critics
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

  # PATCH/PUT /critics/:id
  def update
    @critic = Critic.find(params[:id])

    if @critic.update(critic_params)
      redirect_to @critic
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /critics/:id
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
    params.require(:critic).permit(:title, :body)
  end
end
