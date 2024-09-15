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

ActiveRecord::Schema[7.2].define(version: 2024_09_15_215653) do
  create_table "enrollments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "team_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_enrollments_on_role_id"
    t.index ["team_id"], name: "index_enrollments_on_team_id"
    t.index ["user_id", "team_id"], name: "index_enrollments_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "external_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_teams_on_external_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "external_id", null: false
    t.string "display_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_users_on_external_id", unique: true
  end

  add_foreign_key "enrollments", "roles"
  add_foreign_key "enrollments", "teams"
  add_foreign_key "enrollments", "users"
end
