class UsersController < ApplicationController
  # GET /profile
  def show
    @user = User.find(params[:id])
  end
  def likes
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end
  
  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets_created
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def create
  #   @user = User.new(user_params)
  #     if @user.save
  #       redirect_to @user
  #     else
  #       render :new, status: :unprocessable_entity
  #     end
  # end

  # def update
  #   @user = User.find(params[:id])

  #   if @user.update(user_params)
  #     redirect_to @user
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  # private

  # def user_params
  #   params.require(:user).permit(:email, :username, :name)
  # end
end
