class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  validates :body, presence: true, length: { maximum: 140 }

  # Associations
  belongs_to :replied_to, class_name: "Tweet", optional: true, counter_cache: :replies_count
  has_many :replies, class_name: "Tweet",
                        foreign_key: "replied_to_id",
                        dependent: :nullify,
                        inverse_of: "replied_to"
  validates :replied_to, inclusion: { in: proc { Tweet.all },
                          message: "is not a valid tweet" },
                          allow_blank: true
  
end
