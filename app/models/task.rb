class Task < ActiveRecord::Base

  validates :title, presence: true
  validates :text, presence: true
  validates :rating, presence: true

  has_many :attempts
  has_many :users, through: :attempts
  has_many :comments
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :section

  serialize :answers, JSON

  acts_as_taggable
  acts_as_taggable_on

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.search(query)
    __elasticsearch__.search(
        {
            query: {
                multi_match: {
                    query: query,
                    fields: ['title^10', 'text']
                }
            },
            highlight: {
                pre_tags: ['<em>'],
                post_tags: ['</em>'],
                fields: {
                    title: {},
                    text: {}
                }
            }
        }
    )
  end

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english'
      indexes :text, analyzer: 'english'
    end
  end

  Task.__elasticsearch__.client.indices.delete index: Task.index_name rescue nil
  # Create the new index with the new mapping
  Task.__elasticsearch__.client.indices.create \
    index: Task.index_name,
  body: { settings: Task.settings.to_hash, mappings: Task.mappings.to_hash }

  # Index all article records from the DB to Elasticsearch
  Task.import
end
