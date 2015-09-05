class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :confirmable,
         :omniauth_providers => [:facebook, :vkontakte, :github, :twitter]
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  #attr_accessible :nickname, :provider, :url, :username

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end




  def self.from_omniauth(auth)
    where(provider: auth[:provider], id: auth[:id]).first_or_create do |user|
      user.nickname = auth[:info][:nickname]
      user.email = auth[:info][:email]
    end
  end

end
