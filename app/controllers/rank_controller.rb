class RankController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @likes = Rails.cache.fetch("#{current_user.id}_likes", :expires_in => 1.hours) do
      current_user.facebook_user.likes
    end
  end
end
