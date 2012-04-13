class User < ActiveRecord::Base
  devise :omniauthable
  
  has_one :connect

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    if connect = Connect.find_by_provider_and_uid(auth["provider"], auth["uid"])
      Connect.update_with_omniauth(connect.id, auth, connect.user)
      return connect.user
    else # Create a user with a stub password. 
      ActiveRecord::Base.transaction do
        user = User.create!(
          :name        => auth.info.name,
          :email       => nil,
          :screen_name => auth.info.nickname || auth.uid.to_s,
          :image       => auth.info.image,
          :url         => auth.info.urls.facebook,
          :timezone    => auth.extra.raw_info.timezone,
          :locale      => I18n.locale.to_s
        )
        Connect.create_with_omniauth(auth, user)
        return user
      end
    end
  end

  def facebook_user
    connect = self.connect
    if connect.blank?
      []
    else
      FbGraph::User.me(connect.token)
    end
  end
  
  def facebook_friends
    fb_user = facebook_user
    return [] if fb_user.blank?

    return User.joins(:connect).where(["connects.uid IN (?)", fb_user.friends.map{|u| u.identifier}])
  end
end
