class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :choices, :choice, :name
  end
end
