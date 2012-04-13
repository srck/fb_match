class Connect < ActiveRecord::Base
  belongs_to :user

  def self.create_with_omniauth(auth, user)
    connect = self.new
    connect.user_id = user.id
    connect.provider = auth.provider
    connect.uid = auth.uid.to_s
    connect.token = auth.credentials.token
    connect.save
  end
  
  def self.update_with_omniauth(id, auth, user)
    self.update(id, 
      :user_id  => user.id,
      :provider => auth.provider,
      :uid      => auth.uid.to_s,
      :token    => auth.credentials.token
    )
  end

end
