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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130503121237) do

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.float    "total_price"
    t.boolean  "status",      :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "move_to_que", :default => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "damage_product_lists", :force => true do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "category_id"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "user_id"
    t.float    "total"
    t.integer  "cart_id"
    t.boolean  "status",          :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.date     "return_date"
    t.date     "purchasing_date"
  end

  create_table "locations", :force => true do |t|
    t.string   "location_name"
    t.text     "location_description"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.boolean  "status"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "from_user_id"
    t.text     "reply_content"
    t.string   "subject"
    t.boolean  "read_status",   :default => false
    t.boolean  "delete_status", :default => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "quantity"
    t.integer  "trigger"
    t.date     "purchase_date"
    t.float    "price"
    t.integer  "location_id",                           :null => false
    t.integer  "category_id",                           :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "value"
    t.boolean  "priority",           :default => false
    t.integer  "sorting_value"
  end

  create_table "records", :force => true do |t|
    t.integer  "user_id"
    t.integer  "quantity"
    t.date     "purchase_date"
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.date     "return_item_date"
    t.boolean  "return_status",       :default => false
    t.string   "item_recieve_status"
    t.integer  "delay_by"
    t.boolean  "move_to_damage",      :default => false
    t.integer  "cart_id"
  end

  create_table "user_details", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.integer  "contact_number"
    t.string   "position"
    t.text     "address"
    t.integer  "user_id",            :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "user_role",              :default => 201
    t.boolean  "status",                 :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
