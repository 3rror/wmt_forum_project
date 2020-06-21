class TopicSubscription < ApplicationRecord
  belongs_to :user, inverse_of: :topic_subscriptions
  belongs_to :topic, inverse_of: :topic_subscriptions
end
