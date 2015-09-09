class CreateAchivements < ActiveRecord::Migration
  def change
    create_table :achivements do |t|
      t.string :name
      t.timestamps
    end
  end
end
