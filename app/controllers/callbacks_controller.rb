class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      # sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      # set_flash_message(:notice, :success, kind: "GitHub") if is_navigational_format?
      sign_in_and_redirect @user
      flash[:notice] = "sucessful log in!"
    else
      # session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, alert: "Couldn't log in"
    end
    # sign_in_and_redirect @user
  end
end
