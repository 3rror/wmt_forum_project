class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :topic_subscriptions, dependent: :destroy
  has_many :subscribed_topics, through: :topic_subscriptions, source: :topic

  has_one_attached :avatar, dependent: :destroy

  validates :username, presence: true, length: { maximum: 60 }, uniqueness: { case_sensitive: false }
end
