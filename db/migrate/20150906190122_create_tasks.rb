class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title,
      t.text :text
      t.integer :rating,
      t.timestamps
    end
  end
end
