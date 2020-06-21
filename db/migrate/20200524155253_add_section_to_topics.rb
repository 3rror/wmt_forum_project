class AddSectionToTopics < ActiveRecord::Migration[6.0]
  def change
    add_reference :topics, :topic_section, null: false, foreign_key: true
  end
end
