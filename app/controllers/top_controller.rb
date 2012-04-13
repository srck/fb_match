class TopController < ApplicationController
  def show
    unless user_signed_in?
      render "before_login"
    else
      redirect_to rank_path
    end
  end
end
