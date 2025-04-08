# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_03_27_105622) do
  create_table "attachments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.string "file_name", null: false
    t.string "s3_uri", null: false
    t.bigint "uploaded_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_attachments_on_task_id"
    t.index ["uploaded_by_id"], name: "index_attachments_on_uploaded_by_id"
  end

  create_table "comments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.text "message", null: false
    t.boolean "is_edited", default: false, null: false
    t.bigint "posted_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["posted_by_id"], name: "index_comments_on_posted_by_id"
    t.index ["task_id"], name: "index_comments_on_task_id"
  end

  create_table "projects", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_projects_on_created_by_id"
  end

  create_table "sprints", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.bigint "project_id", null: false
    t.text "description"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_sprints_on_created_by_id"
    t.index ["project_id"], name: "index_sprints_on_project_id"
  end

  create_table "task_dependencies", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "dependent_task_id", null: false
    t.bigint "dependency_task_id", null: false
    t.string "dependency_type", default: "depends_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dependency_task_id"], name: "index_task_dependencies_on_dependency_task_id"
    t.index ["dependent_task_id"], name: "index_task_dependencies_on_dependent_task_id"
  end

  create_table "tasks", charset: "utf8mb3", force: :cascade do |t|
    t.string "task_type", null: false
    t.text "description"
    t.bigint "sprint_id"
    t.date "start_date"
    t.date "due_date"
    t.date "end_date"
    t.integer "points", default: 0
    t.string "status", default: "open", null: false
    t.string "priority", default: "low", null: false
    t.bigint "assignee_id"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["created_by_id"], name: "index_tasks_on_created_by_id"
    t.index ["sprint_id"], name: "index_tasks_on_sprint_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 3, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "attachments", "tasks"
  add_foreign_key "attachments", "users", column: "uploaded_by_id"
  add_foreign_key "comments", "tasks"
  add_foreign_key "comments", "users", column: "posted_by_id"
  add_foreign_key "projects", "users", column: "created_by_id"
  add_foreign_key "sprints", "projects"
  add_foreign_key "sprints", "users", column: "created_by_id"
  add_foreign_key "task_dependencies", "tasks", column: "dependency_task_id"
  add_foreign_key "task_dependencies", "tasks", column: "dependent_task_id"
  add_foreign_key "tasks", "sprints"
  add_foreign_key "tasks", "users", column: "assignee_id"
  add_foreign_key "tasks", "users", column: "created_by_id"
end
