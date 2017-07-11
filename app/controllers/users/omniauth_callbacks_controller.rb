class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    @User = User.from_omniauth(request.env["omniauth.auth"])
    if @User.persisted?
      @User.remember_me = true
      sign_in_and_redirect @User, event: :authentication
    end
  end
end
