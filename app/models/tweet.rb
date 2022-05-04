class Tweet < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :likes, class_name: "User", counter_cache: :true
  validates :body, presence: true, length: { maximum: 140 }

  # Associations
  belongs_to :replied_to, class_name: "Tweet", optional: true
  has_many :replies, class_name: "Tweet",
                        counter_cache: :true,
                        foreign_key: "replied_to_id",
                        dependent: :nullify,
                        inverse_of: "replied_to"
  validates :replied_to, inclusion: { in: proc { Tweet.all },
                          message: "is not a valid tweet" },
                          allow_blank: true
  
end
