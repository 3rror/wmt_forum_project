class TopicSection < ApplicationRecord
  has_many :topics, -> { includes(posts: :user) }

  validates :name, presence: true, length: { maximum: 30 }
end
