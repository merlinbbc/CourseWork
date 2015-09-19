require 'elasticsearch/model'

class Task < ActiveRecord::Base

  validates :title, presence: true
  validates :text, presence: true
  validates :rating, presence: true

  has_many :attempts
  has_many :users, through: :attempts
  has_many :comments, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :section

  serialize :answers, JSON

  acts_as_taggable
  acts_as_taggable_on

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  paginates_per 5


  def self.search(query)
    __elasticsearch__.search(
        {
            query: {
                multi_match: {
                    query: query,
                    fields: ['title^10', 'text']
                }
            }
        }
    )
  end

end

Task.import