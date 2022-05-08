class Api::RegistrationsController < ApiController
  skip_before_action :authorize, only: %i[create]

  def create
    p "="*50
    p request.raw_post
    p JSON.parse(request.raw_post)
    p "="*50 
    @user = User.new(JSON.parse(request.raw_post))
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

end