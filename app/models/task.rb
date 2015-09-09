class Task < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  validates :rating, presence: true
end
