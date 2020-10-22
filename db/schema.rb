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

ActiveRecord::Schema.define(version: 20160430230756) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",                  null: false
    t.string   "resource_type",                null: false
    t.integer  "author_id",     precision: 38
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "i_act_adm_com_aut_typ_aut_id"
  add_index "active_admin_comments", ["namespace"], name: "i_act_adm_com_nam"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "i_act_adm_com_res_typ_res_id"

  create_table "admin_orders", force: :cascade do |t|
    t.integer  "quantity",      precision: 38, null: false
    t.integer  "admin_user_id", precision: 38
    t.integer  "product_id",    precision: 38
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "admin_orders", ["admin_user_id"], name: "i_admin_orders_admin_user_id"
  add_index "admin_orders", ["product_id"], name: "i_admin_orders_product_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                                 default: "", null: false
    t.string   "encrypted_password",                    default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          precision: 38, default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "i_adm_use_res_pas_tok", unique: true

  create_table "carts", force: :cascade do |t|
    t.integer  "quantity",   precision: 38, default: 0, null: false
    t.integer  "product_id", precision: 38
    t.integer  "user_id",    precision: 38
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "carts", ["product_id"], name: "index_carts_on_product_id"
  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name",                      null: false
    t.integer  "parent_id",  precision: 38
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id"

  create_table "couriers", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.boolean  "delivered",  limit: nil,                null: false
    t.string   "city"
    t.string   "street"
    t.string   "address"
    t.string   "pdf"
    t.integer  "total",                  precision: 38, null: false
    t.integer  "user_id",                precision: 38
    t.integer  "courier_id",             precision: 38
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "invoices", ["courier_id"], name: "index_invoices_on_courier_id"
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "quantity",   precision: 38, null: false
    t.integer  "invoice_id", precision: 38
    t.integer  "product_id", precision: 38
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "orders", ["invoice_id"], name: "index_orders_on_invoice_id"
  add_index "orders", ["product_id"], name: "index_orders_on_product_id"

  create_table "products", force: :cascade do |t|
    t.integer  "price",           precision: 38, null: false
    t.float    "discount"
    t.string   "name",                           null: false
    t.integer  "stock",           precision: 38, null: false
    t.text     "description"
    t.integer  "wholesale_price", precision: 38, null: false
    t.string   "image_url"
    t.integer  "category_id",     precision: 38
    t.integer  "vendor_id",       precision: 38
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"
  add_index "products", ["vendor_id"], name: "index_products_on_vendor_id"

  create_table "ratings", force: :cascade do |t|
    t.integer  "rating",     precision: 38, null: false
    t.text     "note"
    t.integer  "product_id", precision: 38
    t.integer  "user_id",    precision: 38
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "ratings", ["product_id"], name: "index_ratings_on_product_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider",                                              null: false
    t.string   "uid",                                                   null: false
    t.string   "image_url"
    t.string   "email"
    t.string   "name"
    t.string   "phone"
    t.string   "city"
    t.string   "street"
    t.string   "address"
    t.integer  "balance",                precision: 38, default: 0
    t.boolean  "regular",    limit: nil,                default: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "users", ["provider", "uid"], name: "i_users_provider_uid", unique: true
  add_index "users", ["provider"], name: "index_users_on_provider"
  add_index "users", ["uid"], name: "index_users_on_uid"

  create_table "vendors", force: :cascade do |t|
    t.string   "email",      null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
