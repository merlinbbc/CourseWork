class CreateAchievementsUsers < ActiveRecord::Migration
  def change
    create_table :achievements_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :achievement, index: true
      t.timestamps
    end
  end
end
