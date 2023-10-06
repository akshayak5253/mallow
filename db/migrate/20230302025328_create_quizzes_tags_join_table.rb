class CreateQuizzesTagsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes_tags, id: false do |t|
      t.bigint :quiz_id
      t.bigint :tag_id
    end

    add_index :quizzes_tags, :quiz_id
    add_index :quizzes_tags, :tag_id
  end
end
