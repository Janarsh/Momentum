class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.references :task, null: false, foreign_key: true
      t.text :message, null: false
      t.boolean :is_edited, null: false, default: false
      t.references :posted_by, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
