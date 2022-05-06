class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :role, :integer
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_index :users, :username, unique: true
  end
end
