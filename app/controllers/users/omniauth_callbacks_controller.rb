class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    sign_in(:user, @user)
    
    redirect_to root_path
  end
end
