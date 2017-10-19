# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20171019004027) do

  create_table "student_requests", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "sid"
    t.string   "request_type"
    t.string   "course"
    t.string   "residency_status"
    t.boolean  "transfer_student"
    t.boolean  "concurrency_student"
    t.string   "tutor"
    t.time     "start_time"
    t.time     "end_time"
    t.text     "notes"
    t.string   "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sid"
    t.boolean  "transfer_student"
    t.boolean  "concurrency_student"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "tutor_work_days", force: :cascade do |t|
    t.integer  "tutor_sid"
    t.integer  "start_time"
    t.integer  "end_time"
    t.string   "num_students"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tutors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
