class User < ApplicationRecord
  before_create :check_avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true

  # Enums
  enum role: { member: 0, admin: 1 }

  # Association
  has_many :likes, dependent: :destroy
  has_many :tweets, through: :likes, dependent: :destroy
  has_many :tweets_created, class_name: "Tweet"
  has_one_attached :avatar


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.name = auth.info.nickname
      user.password = Devise.friendly_token[0,20]
    end
  end
  
    
  private
  def check_avatar
    return if avatar.attached?
    avatar.attach(io: File.open("app/assets/images/default_avatar.png"),
                  filename: "default_avatar.png")
  end
end
