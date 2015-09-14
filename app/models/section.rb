class Section < ActiveRecord::Base
  validates :section_id, presence: true
  has_many :tasks
end
