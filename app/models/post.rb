# Post represents a generic post belonging to a Topic.
class Post < ApplicationRecord
  searchkick
  extend Pagy::Search

  belongs_to :topic, touch: true, counter_cache: true
  belongs_to :user

  has_rich_text :content

  validates :content, presence: true, length: { maximum: 60000 }

  def author
    user
  end

  def search_data
    {
      content: content.to_plain_text
    }
  end
end
