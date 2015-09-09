class CreateAchievmentsUsers < ActiveRecord::Migration
  def change
    create_table :achievments_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :achievment, index: true
      t.timestamps
    end
  end
end
