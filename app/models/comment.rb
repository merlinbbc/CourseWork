class Comment < ActiveRecord::Base
  belongs_to :users
  belongs_to :tasks
  validates :this_comment, presence: true, length: { maximum: 250 }
end
