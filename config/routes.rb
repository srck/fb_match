FbMatch::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :users do
    get 'users/sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end

  root :to => "top#show"
end
