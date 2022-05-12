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

ActiveRecord::Schema[7.0].define(version: 2022_05_12_060304) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "laws", force: :cascade do |t|
    t.string "sr_number", null: false
    t.string "title", null: false
    t.string "title_alternative"
    t.string "language", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "revisions", force: :cascade do |t|
    t.string "date_document"
    t.string "date_applicability", null: false
    t.string "language_tag", null: false
    t.string "file_uri", null: false
    t.text "legislative_text", null: false
    t.bigint "law_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["law_id"], name: "index_revisions_on_law_id"
  end

end
