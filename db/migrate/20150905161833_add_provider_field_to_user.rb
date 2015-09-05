class AddProviderFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_index :users, :provider
  end
end
