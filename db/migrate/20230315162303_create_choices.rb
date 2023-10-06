class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.string :choice
      t.references :question
      t.timestamps
    end
  end
end
