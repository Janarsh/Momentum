class ChangeRoleTypeUser < ActiveRecord::Migration[7.2]
  def up
    # First, add a temporary column with integer type
    add_column :users, :role_temp, :integer, default: 3, null: false

    # Migrate existing string values to integers
    User.reset_column_information
    User.find_each do |user|
      user.update_column(:role_temp, case user.role
                                     when 'admin' then 0
                                     when 'sprint_admin' then 1
                                     when 'task_admin' then 2
                                     when 'user' then 3
                                     else 3
                                     end)
    end

    # Remove the old string column and rename the new column
    remove_column :users, :role
    rename_column :users, :role_temp, :role
  end

  def down
    # Rollback: Convert back to string
    add_column :users, :role_temp, :string, default: 'user', null: false

    User.reset_column_information
    User.find_each do |user|
      user.update_column(:role_temp, case user.role
                                     when 0 then 'admin'
                                     when 1 then 'sprint_admin'
                                     when 2 then 'task_admin'
                                     when 3 then 'user'
                                     else 'user'
                                     end)
    end

    remove_column :users, :role
    rename_column :users, :role_temp, :role
  end
end
