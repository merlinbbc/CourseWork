class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :text
      t.integer :rating
      t.text :answers, array: true
      t.string :section
      t.belongs_to :author
      t.timestamps
    end
  end
end
