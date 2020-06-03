# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_01_042620) do

  create_table "environments", force: :cascade do |t|
    t.string "name"
    t.string "private_key_path"
    t.string "fqdn"
    t.string "user_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "executions", force: :cascade do |t|
    t.string "aasm_state"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "input"
    t.string "output"
    t.integer "user_id", null: false
    t.integer "environment_id", null: false
    t.integer "script_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["environment_id"], name: "index_executions_on_environment_id"
    t.index ["script_id"], name: "index_executions_on_script_id"
    t.index ["user_id"], name: "index_executions_on_user_id"
  end

  create_table "scripts", force: :cascade do |t|
    t.string "title"
    t.text "code"
    t.string "aasm_state"
    t.string "path_to_application"
    t.string "command"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "roles", default: {}
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "executions", "environments"
  add_foreign_key "executions", "scripts"
  add_foreign_key "executions", "users"
end
