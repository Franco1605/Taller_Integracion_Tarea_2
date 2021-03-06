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

ActiveRecord::Schema.define(version: 2020_04_27_014816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "hamburgers", force: :cascade do |t|
    t.text "nombre"
    t.integer "precio"
    t.text "descripcion"
    t.text "imagen"
    t.hstore "ingredientes", default: [], null: false, array: true
  end

  create_table "hamburgers_ingredients", id: false, force: :cascade do |t|
    t.bigint "hamburger_id"
    t.bigint "ingredient_id"
    t.index ["hamburger_id"], name: "index_hamburgers_ingredients_on_hamburger_id"
    t.index ["ingredient_id"], name: "index_hamburgers_ingredients_on_ingredient_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.text "nombre"
    t.text "descripcion"
  end

  add_foreign_key "hamburgers_ingredients", "hamburgers"
  add_foreign_key "hamburgers_ingredients", "ingredients"
end
