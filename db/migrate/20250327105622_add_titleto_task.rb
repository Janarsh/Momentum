class AddTitletoTask < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :name, :string, null: false
  end
end
