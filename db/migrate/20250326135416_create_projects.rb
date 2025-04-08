class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description, null: true
      t.references :created_by, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
