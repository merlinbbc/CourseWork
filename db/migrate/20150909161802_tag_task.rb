class TagTask < ActiveRecord::Migration
  def change
    create_table :tags_tasks, id: false do |t|
      t.belongs_to :task, index: true
      t.belongs_to :tags, index: true
      t.timestamps
    end
  end
end
