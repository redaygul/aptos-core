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

ActiveRecord::Schema[7.0].define(version: 2022_07_07_181731) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.text "content", null: false
    t.string "status", default: "draft", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.string "email"
    t.string "username"
    t.string "full_name"
    t.text "profile_url"
    t.string "token"
    t.string "secret"
    t.string "refresh_token"
    t.boolean "expires"
    t.datetime "expires_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authorizations_on_provider_and_uid"
    t.index ["provider"], name: "index_authorizations_on_provider"
    t.index ["uid"], name: "index_authorizations_on_uid"
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "directus_activity", id: :serial, force: :cascade do |t|
    t.string "action", limit: 45, null: false
    t.uuid "user"
    t.timestamptz "timestamp", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "ip", limit: 50
    t.string "user_agent", limit: 255
    t.string "collection", limit: 64, null: false
    t.string "item", limit: 255, null: false
    t.text "comment"
  end

  create_table "directus_collections", primary_key: "collection", id: { type: :string, limit: 64 }, force: :cascade do |t|
    t.string "icon", limit: 30
    t.text "note"
    t.string "display_template", limit: 255
    t.boolean "hidden", default: false, null: false
    t.boolean "singleton", default: false, null: false
    t.json "translations"
    t.string "archive_field", limit: 64
    t.boolean "archive_app_filter", default: true, null: false
    t.string "archive_value", limit: 255
    t.string "unarchive_value", limit: 255
    t.string "sort_field", limit: 64
    t.string "accountability", limit: 255, default: "all"
    t.string "color", limit: 255
    t.json "item_duplication_fields"
    t.integer "sort"
    t.string "group", limit: 64
    t.string "collapse", limit: 255, default: "open", null: false
  end

  create_table "directus_dashboards", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "icon", limit: 30, default: "dashboard", null: false
    t.text "note"
    t.timestamptz "date_created", default: -> { "CURRENT_TIMESTAMP" }
    t.uuid "user_created"
    t.string "color", limit: 255
  end

  create_table "directus_fields", id: :serial, force: :cascade do |t|
    t.string "collection", limit: 64, null: false
    t.string "field", limit: 64, null: false
    t.string "special", limit: 64
    t.string "interface", limit: 64
    t.json "options"
    t.string "display", limit: 64
    t.json "display_options"
    t.boolean "readonly", default: false, null: false
    t.boolean "hidden", default: false, null: false
    t.integer "sort"
    t.string "width", limit: 30, default: "full"
    t.json "translations"
    t.text "note"
    t.json "conditions"
    t.boolean "required", default: false
    t.string "group", limit: 64
    t.json "validation"
    t.text "validation_message"
  end

  create_table "directus_files", id: :uuid, default: nil, force: :cascade do |t|
    t.string "storage", limit: 255, null: false
    t.string "filename_disk", limit: 255
    t.string "filename_download", limit: 255, null: false
    t.string "title", limit: 255
    t.string "type", limit: 255
    t.uuid "folder"
    t.uuid "uploaded_by"
    t.timestamptz "uploaded_on", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.uuid "modified_by"
    t.timestamptz "modified_on", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "charset", limit: 50
    t.bigint "filesize"
    t.integer "width"
    t.integer "height"
    t.integer "duration"
    t.string "embed", limit: 200
    t.text "description"
    t.text "location"
    t.text "tags"
    t.json "metadata"
  end

  create_table "directus_flows", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "icon", limit: 30
    t.string "color", limit: 255
    t.text "description"
    t.string "status", limit: 255, default: "active", null: false
    t.string "trigger", limit: 255
    t.string "accountability", limit: 255, default: "all"
    t.json "options"
    t.uuid "operation"
    t.timestamptz "date_created", default: -> { "CURRENT_TIMESTAMP" }
    t.uuid "user_created"
    t.index ["operation"], name: "directus_flows_operation_unique", unique: true
  end

  create_table "directus_folders", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.uuid "parent"
  end

  create_table "directus_migrations", primary_key: "version", id: { type: :string, limit: 255 }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.timestamptz "timestamp", default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "directus_notifications", id: :serial, force: :cascade do |t|
    t.timestamptz "timestamp", null: false
    t.string "status", limit: 255, default: "inbox"
    t.uuid "recipient", null: false
    t.uuid "sender"
    t.string "subject", limit: 255, null: false
    t.text "message"
    t.string "collection", limit: 64
    t.string "item", limit: 255
  end

  create_table "directus_operations", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "key", limit: 255, null: false
    t.string "type", limit: 255, null: false
    t.integer "position_x", null: false
    t.integer "position_y", null: false
    t.json "options"
    t.uuid "resolve"
    t.uuid "reject"
    t.uuid "flow", null: false
    t.timestamptz "date_created", default: -> { "CURRENT_TIMESTAMP" }
    t.uuid "user_created"
    t.index ["reject"], name: "directus_operations_reject_unique", unique: true
    t.index ["resolve"], name: "directus_operations_resolve_unique", unique: true
  end

  create_table "directus_panels", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "dashboard", null: false
    t.string "name", limit: 255
    t.string "icon", limit: 30
    t.string "color", limit: 10
    t.boolean "show_header", default: false, null: false
    t.text "note"
    t.string "type", limit: 255, null: false
    t.integer "position_x", null: false
    t.integer "position_y", null: false
    t.integer "width", null: false
    t.integer "height", null: false
    t.json "options"
    t.timestamptz "date_created", default: -> { "CURRENT_TIMESTAMP" }
    t.uuid "user_created"
  end

  create_table "directus_permissions", id: :serial, force: :cascade do |t|
    t.uuid "role"
    t.string "collection", limit: 64, null: false
    t.string "action", limit: 10, null: false
    t.json "permissions"
    t.json "validation"
    t.json "presets"
    t.text "fields"
  end

  create_table "directus_presets", id: :serial, force: :cascade do |t|
    t.string "bookmark", limit: 255
    t.uuid "user"
    t.uuid "role"
    t.string "collection", limit: 64
    t.string "search", limit: 100
    t.string "layout", limit: 100, default: "tabular"
    t.json "layout_query"
    t.json "layout_options"
    t.integer "refresh_interval"
    t.json "filter"
    t.string "icon", limit: 30, default: "bookmark_outline", null: false
    t.string "color", limit: 255
  end

  create_table "directus_relations", id: :serial, force: :cascade do |t|
    t.string "many_collection", limit: 64, null: false
    t.string "many_field", limit: 64, null: false
    t.string "one_collection", limit: 64
    t.string "one_field", limit: 64
    t.string "one_collection_field", limit: 64
    t.text "one_allowed_collections"
    t.string "junction_field", limit: 64
    t.string "sort_field", limit: 64
    t.string "one_deselect_action", limit: 255, default: "nullify", null: false
  end

  create_table "directus_revisions", id: :serial, force: :cascade do |t|
    t.integer "activity", null: false
    t.string "collection", limit: 64, null: false
    t.string "item", limit: 255, null: false
    t.json "data"
    t.json "delta"
    t.integer "parent"
  end

  create_table "directus_roles", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "icon", limit: 30, default: "supervised_user_circle", null: false
    t.text "description"
    t.text "ip_access"
    t.boolean "enforce_tfa", default: false, null: false
    t.boolean "admin_access", default: false, null: false
    t.boolean "app_access", default: true, null: false
  end

  create_table "directus_sessions", primary_key: "token", id: { type: :string, limit: 64 }, force: :cascade do |t|
    t.uuid "user"
    t.timestamptz "expires", null: false
    t.string "ip", limit: 255
    t.string "user_agent", limit: 255
    t.uuid "share"
  end

  create_table "directus_settings", id: :serial, force: :cascade do |t|
    t.string "project_name", limit: 100, default: "Directus", null: false
    t.string "project_url", limit: 255
    t.string "project_color", limit: 50
    t.uuid "project_logo"
    t.uuid "public_foreground"
    t.uuid "public_background"
    t.text "public_note"
    t.integer "auth_login_attempts", default: 25
    t.string "auth_password_policy", limit: 100
    t.string "storage_asset_transform", limit: 7, default: "all"
    t.json "storage_asset_presets"
    t.text "custom_css"
    t.uuid "storage_default_folder"
    t.json "basemaps"
    t.string "mapbox_key", limit: 255
    t.json "module_bar"
    t.string "project_descriptor", limit: 100
    t.json "translation_strings"
    t.string "default_language", limit: 255, default: "en-US", null: false
  end

  create_table "directus_shares", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "collection", limit: 64
    t.string "item", limit: 255
    t.uuid "role"
    t.string "password", limit: 255
    t.uuid "user_created"
    t.timestamptz "date_created", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "date_start"
    t.timestamptz "date_end"
    t.integer "times_used", default: 0
    t.integer "max_uses"
  end

  create_table "directus_users", id: :uuid, default: nil, force: :cascade do |t|
    t.string "first_name", limit: 50
    t.string "last_name", limit: 50
    t.string "email", limit: 128
    t.string "password", limit: 255
    t.string "location", limit: 255
    t.string "title", limit: 50
    t.text "description"
    t.json "tags"
    t.uuid "avatar"
    t.string "language", limit: 255
    t.string "theme", limit: 20, default: "auto"
    t.string "tfa_secret", limit: 255
    t.string "status", limit: 16, default: "active", null: false
    t.uuid "role"
    t.string "token", limit: 255
    t.timestamptz "last_access"
    t.string "last_page", limit: 255
    t.string "provider", limit: 128, default: "default", null: false
    t.string "external_identifier", limit: 255
    t.json "auth_data"
    t.boolean "email_notifications", default: true
    t.index ["email"], name: "directus_users_email_unique", unique: true
    t.index ["external_identifier"], name: "directus_users_external_identifier_unique", unique: true
    t.index ["token"], name: "directus_users_token_unique", unique: true
  end

  create_table "directus_webhooks", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "method", limit: 10, default: "POST", null: false
    t.text "url", null: false
    t.string "status", limit: 10, default: "active", null: false
    t.boolean "data", default: true, null: false
    t.string "actions", limit: 100, null: false
    t.text "collections", null: false
    t.json "headers"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "it1_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "consensus_key"
    t.string "account_key"
    t.string "network_key"
    t.string "validator_ip"
    t.string "validator_address"
    t.integer "validator_port"
    t.integer "validator_metrics_port"
    t.integer "validator_api_port"
    t.boolean "validator_verified", default: false
    t.string "fullnode_address"
    t.integer "fullnode_port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "terms_accepted", default: false
    t.string "fullnode_network_key"
    t.boolean "selected", default: false, null: false, comment: "Whether this node is selected for participation in IT1."
    t.boolean "validator_verified_final"
    t.jsonb "metrics_data"
    t.index ["user_id"], name: "index_it1_profiles_on_user_id"
  end

  create_table "it2_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "consensus_key", null: false
    t.string "account_key", null: false
    t.string "network_key", null: false
    t.string "validator_ip"
    t.string "validator_address", null: false
    t.integer "validator_port", null: false
    t.integer "validator_metrics_port", null: false
    t.integer "validator_api_port", null: false
    t.boolean "validator_verified", default: false, null: false
    t.string "fullnode_address"
    t.integer "fullnode_port"
    t.string "fullnode_network_key"
    t.boolean "terms_accepted", default: false, null: false
    t.boolean "selected", default: false, null: false, comment: "Whether this node is selected for participation in IT2."
    t.boolean "validator_verified_final"
    t.jsonb "metrics_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nhc_job_id"
    t.text "nhc_output"
    t.index ["account_key"], name: "index_it2_profiles_on_account_key", unique: true
    t.index ["consensus_key"], name: "index_it2_profiles_on_consensus_key", unique: true
    t.index ["fullnode_network_key"], name: "index_it2_profiles_on_fullnode_network_key", unique: true
    t.index ["network_key"], name: "index_it2_profiles_on_network_key", unique: true
    t.index ["user_id"], name: "index_it2_profiles_on_user_id", unique: true
  end

  create_table "it2_surveys", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "persona", null: false
    t.string "participate_reason", null: false
    t.string "qualified_reason", null: false
    t.string "website"
    t.string "interest_reason", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_it2_surveys_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.integer "accuracy_radius"
    t.integer "average_income"
    t.float "latitude"
    t.float "longitude"
    t.integer "metro_code"
    t.integer "population_density"
    t.string "time_zone"
    t.boolean "anonymous"
    t.boolean "anonymous_vpn"
    t.integer "autonomous_system_number"
    t.string "autonomous_system_organization"
    t.string "connection_type"
    t.string "domain"
    t.boolean "hosting_provider"
    t.string "ip_address"
    t.string "isp"
    t.boolean "legitimate_proxy"
    t.string "mobile_country_code"
    t.string "mobile_network_code"
    t.string "network"
    t.string "organization"
    t.boolean "public_proxy"
    t.boolean "residential_proxy"
    t.float "static_ip_score"
    t.boolean "tor_exit_node"
    t.integer "user_count"
    t.string "user_type"
    t.string "continent_code"
    t.string "continent_geoname_id"
    t.string "continent_name"
    t.integer "country_confidence"
    t.string "country_geoname_id"
    t.string "country_iso_code"
    t.string "country_name"
    t.integer "subdivision_confidence"
    t.string "subdivision_geoname_id"
    t.string "subdivision_iso_code"
    t.string "subdivision_name"
    t.integer "city_confidence"
    t.string "city_geoname_id"
    t.string "city_name"
    t.integer "postal_confidence"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_locations_on_item"
  end

  create_table "nft_offers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "valid_from"
    t.datetime "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_nft_offers_on_name", unique: true
  end

  create_table "nfts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "nft_offer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "explorer_url"
    t.index ["nft_offer_id"], name: "index_nfts_on_nft_offer_id"
    t.index ["user_id"], name: "index_nfts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "is_root", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_developer", default: false, null: false
    t.boolean "is_node_operator", default: false, null: false
    t.string "mainnet_address"
    t.string "kyc_status", default: "not_started", null: false
    t.uuid "external_id", default: -> { "gen_random_uuid()" }, null: false
    t.boolean "kyc_exempt", default: false
    t.string "completed_persona_inquiry_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["current_sign_in_ip"], name: "index_users_on_current_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["external_id"], name: "index_users_on_external_id"
    t.index ["last_sign_in_ip"], name: "index_users_on_last_sign_in_ip"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "directus_collections", "directus_collections", column: "group", primary_key: "collection", name: "directus_collections_group_foreign"
  add_foreign_key "directus_dashboards", "directus_users", column: "user_created", name: "directus_dashboards_user_created_foreign", on_delete: :nullify
  add_foreign_key "directus_files", "directus_folders", column: "folder", name: "directus_files_folder_foreign", on_delete: :nullify
  add_foreign_key "directus_files", "directus_users", column: "modified_by", name: "directus_files_modified_by_foreign"
  add_foreign_key "directus_files", "directus_users", column: "uploaded_by", name: "directus_files_uploaded_by_foreign"
  add_foreign_key "directus_flows", "directus_users", column: "user_created", name: "directus_flows_user_created_foreign", on_delete: :nullify
  add_foreign_key "directus_folders", "directus_folders", column: "parent", name: "directus_folders_parent_foreign"
  add_foreign_key "directus_notifications", "directus_users", column: "recipient", name: "directus_notifications_recipient_foreign", on_delete: :cascade
  add_foreign_key "directus_notifications", "directus_users", column: "sender", name: "directus_notifications_sender_foreign"
  add_foreign_key "directus_operations", "directus_flows", column: "flow", name: "directus_operations_flow_foreign", on_delete: :cascade
  add_foreign_key "directus_operations", "directus_operations", column: "reject", name: "directus_operations_reject_foreign"
  add_foreign_key "directus_operations", "directus_operations", column: "resolve", name: "directus_operations_resolve_foreign"
  add_foreign_key "directus_operations", "directus_users", column: "user_created", name: "directus_operations_user_created_foreign", on_delete: :nullify
  add_foreign_key "directus_panels", "directus_dashboards", column: "dashboard", name: "directus_panels_dashboard_foreign", on_delete: :cascade
  add_foreign_key "directus_panels", "directus_users", column: "user_created", name: "directus_panels_user_created_foreign", on_delete: :nullify
  add_foreign_key "directus_permissions", "directus_roles", column: "role", name: "directus_permissions_role_foreign", on_delete: :cascade
  add_foreign_key "directus_presets", "directus_roles", column: "role", name: "directus_presets_role_foreign", on_delete: :cascade
  add_foreign_key "directus_presets", "directus_users", column: "user", name: "directus_presets_user_foreign", on_delete: :cascade
  add_foreign_key "directus_revisions", "directus_activity", column: "activity", name: "directus_revisions_activity_foreign", on_delete: :cascade
  add_foreign_key "directus_revisions", "directus_revisions", column: "parent", name: "directus_revisions_parent_foreign"
  add_foreign_key "directus_sessions", "directus_shares", column: "share", name: "directus_sessions_share_foreign", on_delete: :cascade
  add_foreign_key "directus_sessions", "directus_users", column: "user", name: "directus_sessions_user_foreign", on_delete: :cascade
  add_foreign_key "directus_settings", "directus_files", column: "project_logo", name: "directus_settings_project_logo_foreign"
  add_foreign_key "directus_settings", "directus_files", column: "public_background", name: "directus_settings_public_background_foreign"
  add_foreign_key "directus_settings", "directus_files", column: "public_foreground", name: "directus_settings_public_foreground_foreign"
  add_foreign_key "directus_settings", "directus_folders", column: "storage_default_folder", name: "directus_settings_storage_default_folder_foreign", on_delete: :nullify
  add_foreign_key "directus_shares", "directus_collections", column: "collection", primary_key: "collection", name: "directus_shares_collection_foreign", on_delete: :cascade
  add_foreign_key "directus_shares", "directus_roles", column: "role", name: "directus_shares_role_foreign", on_delete: :cascade
  add_foreign_key "directus_shares", "directus_users", column: "user_created", name: "directus_shares_user_created_foreign", on_delete: :nullify
  add_foreign_key "directus_users", "directus_roles", column: "role", name: "directus_users_role_foreign", on_delete: :nullify
  add_foreign_key "it1_profiles", "users"
  add_foreign_key "it2_profiles", "users"
  add_foreign_key "it2_surveys", "users"
  add_foreign_key "nfts", "nft_offers"
  add_foreign_key "nfts", "users"
end
