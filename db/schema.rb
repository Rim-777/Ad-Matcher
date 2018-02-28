ActiveRecord::Schema.define(version: 26022018222000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "status",      null: false
    t.string   "reference",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_ads_on_campaign_id", using: :btree
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer  "verification_id",    null: false
    t.string   "self_reference",     null: false
    t.string   "external_reference", null: false
    t.integer  "status",             null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["verification_id", "external_reference"], name: "index_campaigns_on_verification_id_and_external_reference", using: :btree
    t.index ["verification_id"], name: "index_campaigns_on_verification_id", using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "verification_id", null: false
    t.text     "message",         null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["verification_id"], name: "index_reports_on_verification_id", using: :btree
  end

  create_table "verifications", force: :cascade do |t|
    t.jsonb    "campaign_list", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end
end