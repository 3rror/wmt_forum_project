class AddPostsCounterToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :posts_count, :integer
  end
end
