class CreateAttachments < ActiveRecord::Migration[7.2]
  def change
    create_table :attachments do |t|
      t.references :task, null: false, foreign_key: true
      t.string :file_name, null: false
      t.string :s3_uri, null: false
      t.references :uploaded_by, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
