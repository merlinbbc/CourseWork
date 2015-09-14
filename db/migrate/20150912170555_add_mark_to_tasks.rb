class AddMarkToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :mark, :float, default: 0
    add_column :tasks, :number_of_marks, :integer, default: 0
  end
end
