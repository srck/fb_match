class Users::SessionsController < ApplicationController
  before_filter :authenticate_user!

  def destroy 
    sign_out
    redirect_to root_path
  end
end
