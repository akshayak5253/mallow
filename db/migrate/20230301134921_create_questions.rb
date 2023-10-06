class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.text :brief
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
