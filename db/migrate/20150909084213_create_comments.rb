class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :task, index: true
      t.string :this_comment
      t.timestamps
    end
  end
end
