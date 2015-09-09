class Task < ActiveRecord::Base
  has_many :attempts
  has_many :users, through: :attempts
  has_many :comments
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_one :section

  has_and_belongs_to_many :Tags, index: true
end
