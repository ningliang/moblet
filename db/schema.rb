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

ActiveRecord::Schema.define(version: 20141011181857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_captures", force: true do |t|
    t.integer  "app_session_id"
    t.string   "s3_bucket"
    t.string   "s3_capture_key"
    t.string   "s3_thumbnail_key"
    t.datetime "device_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_events", force: true do |t|
    t.integer  "app_session_id"
    t.string   "name"
    t.string   "params"
    t.datetime "device_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_instances", force: true do |t|
    t.integer  "app_id"
    t.integer  "app_user_id"
    t.string   "device_type"
    t.string   "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_sessions", force: true do |t|
    t.integer  "app_instance_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "app_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apps", force: true do |t|
    t.string   "api_key"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
