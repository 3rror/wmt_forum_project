class CreateTopicSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :topic_subscriptions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :topic, null: false, foreign_key: true

      t.timestamps
    end
    add_index :topic_subscriptions, [:user_id, :topic_id]
  end
end
