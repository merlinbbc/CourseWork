class AddColumnThemeToUser < ActiveRecord::Migration
  def change
    add_column :users, :theme, :integer, default: 0
  end
end
