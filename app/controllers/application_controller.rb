class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!, except: %i[index show]

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  # def pundit_user
  #   current_user
  # end

  # private

  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."

  #   redirect_to(request.referer || root_path)
  # end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :name, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :name, :email, :password, :current_password)}
  end
end
