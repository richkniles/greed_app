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

ActiveRecord::Schema.define(:version => 20120714173841) do

  create_table "games", :force => true do |t|
    t.integer  "player1"
    t.integer  "player2"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "state"
  end

  create_table "players", :force => true do |t|
    t.string   "player_name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "last_active"
  end

  add_index "players", ["email"], :name => "index_players_on_email", :unique => true
  add_index "players", ["player_name"], :name => "index_players_on_player_name", :unique => true
  add_index "players", ["remember_token"], :name => "index_players_on_remember_token"

end
