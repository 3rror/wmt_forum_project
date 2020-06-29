class AddUserToTopic < ActiveRecord::Migration[6.0]
  def change
    add_reference :topics, :user, null: true, foreign_key: true

    Topic.find_each do |topic|
      topic.user = topic.author
      topic.save
    end

    change_column_null(:topics, :user_id, false)
  end
end
