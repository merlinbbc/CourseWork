class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :task, index: true
      t.integer :attempts_count, default: 0
      t.boolean :status, default:false
      t.timestamps
    end
  end
end
