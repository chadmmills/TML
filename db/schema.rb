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

ActiveRecord::Schema.define(version: 20181117133819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_versions", force: :cascade do |t|
    t.bigint "contact_id"
    t.string "name", null: false
    t.string "street_1", null: false
    t.string "street_2", default: ""
    t.string "city", null: false
    t.string "state", default: ""
    t.string "country", default: ""
    t.string "zipcode", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_versions_on_contact_id"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "street_1", null: false
    t.string "street_2", default: ""
    t.string "city", null: false
    t.string "state", default: ""
    t.string "country", default: ""
    t.string "zipcode", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "upload_id"
    t.index ["upload_id"], name: "index_contacts_on_upload_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "event_title", null: false
    t.datetime "event_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailing_list_contacts", id: :serial, force: :cascade do |t|
    t.integer "mailing_list_id", null: false
    t.integer "contact_id", null: false
    t.boolean "is_complete", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_blocked", default: false, null: false
    t.index ["contact_id"], name: "index_mailing_list_contacts_on_contact_id"
    t.index ["mailing_list_id", "contact_id"], name: "index_mailing_list_contacts_on_mailing_list_id_and_contact_id", unique: true
    t.index ["mailing_list_id"], name: "index_mailing_list_contacts_on_mailing_list_id"
  end

  create_table "mailing_lists", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_mailing_lists_on_event_id"
  end

  create_table "uploads", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "contact_versions", "contacts"
  add_foreign_key "contacts", "uploads"
  add_foreign_key "mailing_list_contacts", "contacts", on_delete: :cascade
  add_foreign_key "mailing_list_contacts", "mailing_lists", on_delete: :cascade
  add_foreign_key "mailing_lists", "events"
end
