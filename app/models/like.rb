class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, counter_cache: :likes_count
  validates :tweet, uniqueness: { scope: :user }
end
