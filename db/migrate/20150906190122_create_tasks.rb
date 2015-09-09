class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :text
      t.integer :rating
      t.text :answers, array: true
<<<<<<< HEAD
=======
      t.string :section
      t.belongs_to :author
>>>>>>> 500e676dcc8164427ebbb940edd0c6c2897870fe
      t.timestamps
    end
  end
end
