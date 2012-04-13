class TopController < ApplicationController
  def show
    unless user_signed_in?
      render "before_login"
    else
      redirect_to inbox_path
    end
  end
end
