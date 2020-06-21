class CreateTopicSections < ActiveRecord::Migration[6.0]
  def change
    create_table :topic_sections do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
