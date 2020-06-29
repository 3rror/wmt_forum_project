# Topic represents a generic forum topic.
class Topic < ApplicationRecord
  # It's better to avoid this
  default_scope { order updated_at: :desc }

  belongs_to :topic_section

  has_many :posts, -> { includes(:user).order(created_at: :asc) }, inverse_of: :topic
  has_many :commenters, -> { distinct.with_attached_avatar }, through: :posts, source: :user, dependent: :destroy

  has_many :topic_subscriptions
  has_many :subscribed_users, through: :topic_subscriptions, source: :user, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }

  accepts_nested_attributes_for :posts

  belongs_to :user

  def author
    user
  end
end
