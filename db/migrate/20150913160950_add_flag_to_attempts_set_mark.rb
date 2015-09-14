class AddFlagToAttemptsSetMark < ActiveRecord::Migration
  def change
    add_column :attempts, :set_mark, :boolean, default: false
  end
end
