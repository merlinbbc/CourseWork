class Task < ActiveRecord::Base

  validates :title, presence: true
  validates :text, presence: true
  validates :rating, presence: true

  has_many :attempts
  has_many :users, through: :attempts
  has_many :comments
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_one :section

  has_and_belongs_to_many :Tags, index: true
  serialize :answers, JSON
end
