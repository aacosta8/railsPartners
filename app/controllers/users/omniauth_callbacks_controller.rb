class Users::OmniauthCallbacksController < ApplicationController

  def facebook
    @User = User.from_omniauth(request.env["omniauth.auth"])
    if @User.persisted?
      @User.remember_me = true
      sign_in_and_redirect @User, event: :authentication
    end

    session["devise.auth"] = request.env["omniauth.auth"]

    render :edit
  end

  def custom_sign_up
    @User = User.from_omniauth(session["devise.auth"])
    if @User.update(user_params)
      sign_in_and_redirect @User, event: :authentication
    else
      render :edit
    end
  end

  def failure
    redirect_to new_user_session_path, notice: "No pudimos loguearte "\
                                               "Error: #{params[:error_description]}."\
                                               " Motivo: #{params[:error_reason]}"
  end

  private

  def user_params
    params.require(:user).permit(:username,:email,:name)
  end

end
