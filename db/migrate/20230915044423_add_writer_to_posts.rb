class AddWriterToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :writer, :string
  end
end
