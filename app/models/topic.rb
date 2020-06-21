# Topic represents a generic forum topic.
class Topic < ApplicationRecord
  # It's better to avoid this
  default_scope { order updated_at: :desc }

  belongs_to :topic_section

  has_many :posts, -> { includes(:user).order(created_at: :asc) }, dependent: :destroy, inverse_of: :topic
  has_many :commenters, through: :posts, source: :user

  has_many :topic_subscriptions, dependent: :destroy
  has_many :subscribed_users, through: :topic_subscriptions, source: :user

  validates :title, presence: true, length: { maximum: 100 }

  accepts_nested_attributes_for :posts

  def author
    posts.includes(user: [:avatar_attachment]).first.user
  end
end
