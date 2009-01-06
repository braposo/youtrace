# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081228190959) do

  create_table "devices", :force => true do |t|
    t.string   "brand"
    t.string   "model"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices_users", :id => false, :force => true do |t|
    t.integer "device_id"
    t.integer "user_id"
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.string   "format",      :default => "msg"
    t.text     "text"
    t.boolean  "private",     :default => false
    t.integer  "receiver_id", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_groups", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "group_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo"
    t.integer  "privacy",     :default => 0
    t.decimal  "traced",      :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_traces", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "trace_id"
  end

  create_table "groups_users", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.integer  "level",           :default => 0
    t.boolean  "protect_updates", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer "user_id"
    t.integer "subscriber_id"
    t.boolean "authorized",    :default => false
    t.boolean "paused",        :default => false
  end

  add_index "subscriptions", ["authorized", "subscriber_id", "user_id"], :name => "index_subscriptions_on_user_id_and_subscriber_id_and_authorized"

  create_table "traces", :force => true do |t|
    t.integer  "user_id"
    t.integer  "device_id"
    t.integer  "vehicle_id"
    t.string   "name"
    t.text     "description"
    t.string   "kind",        :default => "Road"
    t.decimal  "length",      :default => 0.0
    t.string   "file"
    t.integer  "status",      :default => 0
    t.integer  "privacy",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.date     "birthdate"
    t.string   "gender"
    t.decimal  "location_lat"
    t.decimal  "location_lon"
    t.string   "photo"
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "users_vehicles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "vehicle_id"
  end

  create_table "vehicles", :force => true do |t|
    t.string   "kind"
    t.string   "make"
    t.string   "model"
    t.string   "displace"
    t.decimal  "highway"
    t.decimal  "city"
    t.decimal  "combined"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
