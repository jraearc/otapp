# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171204132317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "admin_confirmations", primary_key: ["admin_userid", "ref_no"], force: :cascade do |t|
    t.integer "admin_userid", null: false
    t.integer "ref_no", null: false
  end

  create_table "admins", primary_key: "admin_userid", id: :integer, default: nil, force: :cascade do |t|
    t.string "school_pos"
  end

  create_table "applications", primary_key: "ref_no", id: :integer, default: -> { "nextval('application_seq'::regclass)" }, force: :cascade do |t|
    t.integer "course_id"
  end

  create_table "applies", primary_key: ["student_userid", "school_id", "ref_no"], force: :cascade do |t|
    t.integer "student_userid", null: false
    t.integer "school_id", null: false
    t.integer "ref_no", null: false
    t.string "is_received"
  end

  create_table "courses", primary_key: "course_id", id: :integer, default: -> { "nextval('course_seq'::regclass)" }, force: :cascade do |t|
    t.string "course_name"
    t.integer "duration"
    t.string "sector"
    t.float "tuition_fee"
  end

  create_table "manages", primary_key: "admin_userid", id: :integer, default: nil, force: :cascade do |t|
    t.integer "school_id"
  end

  create_table "offers", primary_key: ["school_id", "course_offered_id"], force: :cascade do |t|
    t.integer "school_id", null: false
    t.integer "course_offered_id", null: false
  end

  create_table "schools", primary_key: "school_id", id: :integer, default: -> { "nextval('school_seq'::regclass)" }, force: :cascade do |t|
    t.string "sname"
    t.string "phone"
    t.string "address"
    t.string "email"
  end

  create_table "students", primary_key: "student_userid", id: :integer, default: nil, force: :cascade do |t|
    t.date "birthdate"
    t.string "address"
    t.string "civil_status"
  end

  create_table "users", primary_key: "userid", id: :integer, default: -> { "nextval('user_seq'::regclass)" }, force: :cascade do |t|
    t.string "username"
    t.string "e_mail"
    t.string "name"
    t.string "password_digest"
  end

  add_foreign_key "admin_confirmations", "admins", column: "admin_userid", primary_key: "admin_userid"
  add_foreign_key "admin_confirmations", "applications", column: "ref_no", primary_key: "ref_no"
  add_foreign_key "admins", "users", column: "admin_userid", primary_key: "userid", on_delete: :cascade
  add_foreign_key "applications", "courses", primary_key: "course_id"
  add_foreign_key "applies", "applications", column: "ref_no", primary_key: "ref_no"
  add_foreign_key "applies", "schools", primary_key: "school_id"
  add_foreign_key "applies", "students", column: "student_userid", primary_key: "student_userid"
  add_foreign_key "manages", "admins", column: "admin_userid", primary_key: "admin_userid"
  add_foreign_key "manages", "schools", primary_key: "school_id"
  add_foreign_key "offers", "courses", column: "course_offered_id", primary_key: "course_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "offers", "schools", primary_key: "school_id"
  add_foreign_key "students", "users", column: "student_userid", primary_key: "userid", on_delete: :cascade
end
