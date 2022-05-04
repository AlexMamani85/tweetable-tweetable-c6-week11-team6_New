class CreateJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :tweets do |t|
      # t.index [:user_id, :tweet_id]
      # t.index [:tweet_id, :user_id]
    end
  end
end
