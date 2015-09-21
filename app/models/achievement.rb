class Achievement < ActiveRecord::Base
  has_many :achievements_users
  has_many :users, through: :achievements_users
end
