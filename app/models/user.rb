class User < ActiveRecord::Base
  has_many :attempts
  has_many :tasks, through: :attempts

  has_many :comments
  has_many :author_tasks, foreign_key: "author_id", class_name: 'Taks'

  has_and_belongs_to_many :achivements

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :confirmable,
         :omniauth_providers => [:facebook, :vkontakte, :github, :twitter]

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end


  def self.from_omniauth(auth)
    where(email: auth['info']['email']).first_or_create do |user|
      passwd = Devise.friendly_token.first(8)
      user.password = passwd
      user.password_confirmation = passwd
      user.email = auth['info']['email']

    end
  end

end
