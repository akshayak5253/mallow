class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.string :topic
      t.string :description
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
