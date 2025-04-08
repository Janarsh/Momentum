class CreateTaskDependencies < ActiveRecord::Migration[7.2]
  def change
    create_table :task_dependencies do |t|
      t.references :dependent_task, null: false, foreign_key: { to_table: :tasks }
      t.references :dependency_task, null: false, foreign_key: { to_table: :tasks }
      t.string :dependency_type, null: false, default: "depends_on"

      t.timestamps
    end
  end
end
