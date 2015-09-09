class CreateSection < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.belongs_to :task, index: true
    end
  end
end
