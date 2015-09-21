class User < ActiveRecord::Base
  has_many :attempts
  has_many :tasks, through: :attempts

  has_many :comments
  has_many :author_tasks, foreign_key: "author_id", class_name: 'Taks'

  has_many :achievements_users
  has_many :achievements, through: :achievements_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :confirmable,
         :omniauth_providers => [:facebook, :vkontakte, :github, :twitter]

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end


  def self.find_for_social_oauth(auth)
    User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.confirmed_at = Time.now
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = "#{auth.uid}@#{auth.provider}.com"
      user.password = "password"
      user.nickname = "#{auth.provider}:#{auth.uid}"
    end
  end

end
