class CreateSprints < ActiveRecord::Migration[7.2]
  def change
    create_table :sprints do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :project, null: false, foreign_key: true
      t.text :description, null: true
      t.references :created_by, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
