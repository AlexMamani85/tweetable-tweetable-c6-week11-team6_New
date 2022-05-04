class AddDefaultColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :role, :integer, default: 0
    change_column_default :tweets, :replies_count, from: nil, to: 0
    change_column_default :tweets, :likes_count, from: nil, to: 0
  end
end
