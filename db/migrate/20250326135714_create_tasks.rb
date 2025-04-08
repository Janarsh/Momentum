class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :task_type, null: false
      t.text :description, null: true
      t.references :sprint, foreign_key: true, null: true
      t.date :start_date, null: true
      t.date :due_date, null: true
      t.date :end_date, null: true
      t.integer :points, null: true, default: 0
      t.string :status, null: false, default: "open"
      t.string :priority, null: false, default: "low"
      t.references :assignee, foreign_key: { to_table: :users }, null: true
      t.references :created_by, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
