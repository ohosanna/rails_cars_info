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

ActiveRecord::Schema.define(version: 20151125085017) do

  create_table "acs", force: :cascade do |t|
    t.integer  "model_id",           limit: 4
    t.string   "control_mode",       limit: 255
    t.string   "rear_control",       limit: 255
    t.string   "rear_air_outlet",    limit: 255
    t.string   "temperature_zoning", limit: 255
    t.string   "pollen_filter",      limit: 255
    t.string   "cooler",             limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "acs", ["model_id"], name: "index_acs_on_model_id", using: :btree

  create_table "base_specs", force: :cascade do |t|
    t.integer  "model_id",               limit: 4
    t.string   "name",                   limit: 255
    t.string   "price",                  limit: 255
    t.string   "factory",                limit: 255
    t.string   "level",                  limit: 255
    t.string   "engine",                 limit: 255
    t.string   "gearbox",                limit: 255
    t.string   "LWH",                    limit: 255
    t.string   "body_structure",         limit: 255
    t.string   "max_speed",              limit: 255
    t.string   "acceleration_time",      limit: 255
    t.string   "real_acceleration_time", limit: 255
    t.string   "braking_time",           limit: 255
    t.string   "fuel_consumption",       limit: 255
    t.string   "real_fuel_consumption",  limit: 255
    t.string   "real_ground_clearance",  limit: 255
    t.string   "warranty",               limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "base_specs", ["model_id"], name: "index_base_specs_on_model_id", using: :btree

  create_table "brakes", force: :cascade do |t|
    t.integer  "model_id",           limit: 4
    t.string   "front_brake_type",   limit: 255
    t.string   "rear_brake_type",    limit: 255
    t.string   "parking_brake_type", limit: 255
    t.string   "front_tire_size",    limit: 255
    t.string   "rear_tire_size",     limit: 255
    t.string   "spare_tire_size",    limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "brakes", ["model_id"], name: "index_brakes_on_model_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "autohome_id",  limit: 4
    t.string   "first_letter", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "brands", ["autohome_id"], name: "index_brands_on_autohome_id", using: :btree
  add_index "brands", ["first_letter"], name: "index_brands_on_first_letter", using: :btree

  create_table "consoles", force: :cascade do |t|
    t.integer  "model_id",            limit: 4
    t.string   "ABS",                 limit: 255
    t.string   "EBD",                 limit: 255
    t.string   "EBA",                 limit: 255
    t.string   "ASR",                 limit: 255
    t.string   "ESC",                 limit: 255
    t.string   "HAC",                 limit: 255
    t.string   "auto_hold",           limit: 255
    t.string   "HDC",                 limit: 255
    t.string   "variable_suspension", limit: 255
    t.string   "air_suspension",      limit: 255
    t.string   "variable_gear_ratio", limit: 255
    t.string   "f_XDS",               limit: 255
    t.string   "central_diff_lock",   limit: 255
    t.string   "b_XDS",               limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "consoles", ["model_id"], name: "index_consoles_on_model_id", using: :btree

  create_table "engines", force: :cascade do |t|
    t.integer  "model_id",                limit: 4
    t.string   "name",                    limit: 255
    t.string   "displacement",            limit: 255
    t.string   "intake_type",             limit: 255
    t.string   "cylinder_arrangement",    limit: 255
    t.string   "cylinder_num",            limit: 255
    t.string   "valve_num",               limit: 255
    t.string   "compression_ratio",       limit: 255
    t.string   "valve_train",             limit: 255
    t.string   "cylinder_bore",           limit: 255
    t.string   "piston_stroke",           limit: 255
    t.string   "max_hp",                  limit: 255
    t.string   "max_power",               limit: 255
    t.string   "max_power_speed",         limit: 255
    t.string   "max_torque",              limit: 255
    t.string   "max_torque_speed",        limit: 255
    t.string   "unique_tech",             limit: 255
    t.string   "fuel_type",               limit: 255
    t.string   "fuel_grade",              limit: 255
    t.string   "oil_supply",              limit: 255
    t.string   "cylinder_head_material",  limit: 255
    t.string   "cylinder_block_material", limit: 255
    t.string   "EPA",                     limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "engines", ["model_id"], name: "index_engines_on_model_id", using: :btree

  create_table "exterior_colors", force: :cascade do |t|
    t.integer "autohome_id", limit: 4
    t.string  "name",        limit: 255
    t.string  "value",       limit: 255
  end

  add_index "exterior_colors", ["autohome_id"], name: "index_exterior_colors_on_autohome_id", using: :btree

  create_table "exteriors", force: :cascade do |t|
    t.integer  "model_id",              limit: 4
    t.string   "power_sunroof",         limit: 255
    t.string   "panoramic_sunroof",     limit: 255
    t.string   "sport_appearance",      limit: 255
    t.string   "allowy_wheel",          limit: 255
    t.string   "electric_suction_door", limit: 255
    t.string   "sliding_door",          limit: 255
    t.string   "electric_trunk",        limit: 255
    t.string   "sensing_trunk",         limit: 255
    t.string   "roof_rack",             limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "exteriors", ["model_id"], name: "index_exteriors_on_model_id", using: :btree

  create_table "factories", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "first_letter", limit: 255
    t.integer  "autohome_id",  limit: 4
    t.integer  "brand_id",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "factories", ["autohome_id"], name: "index_factories_on_autohome_id", using: :btree
  add_index "factories", ["brand_id"], name: "index_factories_on_brand_id", using: :btree
  add_index "factories", ["first_letter"], name: "index_factories_on_first_letter", using: :btree

  create_table "h_tech_specs", force: :cascade do |t|
    t.integer  "model_id",                limit: 4
    t.string   "auto_parking",            limit: 255
    t.string   "start_stop",              limit: 255
    t.string   "BLIS",                    limit: 255
    t.string   "LDWS",                    limit: 255
    t.string   "active_safety",           limit: 255
    t.string   "active_dynamic_steering", limit: 255
    t.string   "night_vision",            limit: 255
    t.string   "splitview",               limit: 255
    t.string   "ACC",                     limit: 255
    t.string   "pancam",                  limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "h_tech_specs", ["model_id"], name: "index_h_tech_specs_on_model_id", using: :btree

  create_table "interior_colors", force: :cascade do |t|
    t.integer "autohome_id", limit: 4
    t.string  "name",        limit: 255
    t.string  "values",      limit: 255
  end

  add_index "interior_colors", ["autohome_id"], name: "index_interior_colors_on_autohome_id", using: :btree

  create_table "interiors", force: :cascade do |t|
    t.integer  "model_id",                     limit: 4
    t.string   "leather_steering",             limit: 255
    t.string   "steering_adjestment",          limit: 255
    t.string   "steering_electric_adjestment", limit: 255
    t.string   "MFL",                          limit: 255
    t.string   "paddle_shift",                 limit: 255
    t.string   "LHZ",                          limit: 255
    t.string   "steering_memory",              limit: 255
    t.string   "CCS",                          limit: 255
    t.string   "parking_radar",                limit: 255
    t.string   "CCD",                          limit: 255
    t.string   "ECU_display",                  limit: 255
    t.string   "LED_dashboard",                limit: 255
    t.string   "HUD",                          limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "interiors", ["model_id"], name: "index_interiors_on_model_id", using: :btree

  create_table "lamps", force: :cascade do |t|
    t.integer  "model_id",                limit: 4
    t.string   "low_beam",                limit: 255
    t.string   "high_beam",               limit: 255
    t.string   "DRL",                     limit: 255
    t.string   "adaptive_distance_light", limit: 255
    t.string   "auto_headlamp",           limit: 255
    t.string   "cornering_lamp",          limit: 255
    t.string   "cornering_headlamp",      limit: 255
    t.string   "front_fog_lamp",          limit: 255
    t.string   "headling_adjustable",     limit: 255
    t.string   "SRA",                     limit: 255
    t.string   "ambient_lighting",        limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "lamps", ["model_id"], name: "index_lamps_on_model_id", using: :btree

  create_table "mirrors", force: :cascade do |t|
    t.integer  "model_id",                 limit: 4
    t.string   "power_window",             limit: 255
    t.string   "anti_pinch",               limit: 255
    t.string   "insulating_glass",         limit: 255
    t.string   "power_adjustable",         limit: 255
    t.string   "heated",                   limit: 255
    t.string   "anti_dazzling",            limit: 255
    t.string   "electrically_folding",     limit: 255
    t.string   "memory",                   limit: 255
    t.string   "rear_windshield_sunshade", limit: 255
    t.string   "rear_side_sunshade",       limit: 255
    t.string   "rear_privacy_glass",       limit: 255
    t.string   "sun_visor",                limit: 255
    t.string   "rear_wiper",               limit: 255
    t.string   "sensing_wiper",            limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "mirrors", ["model_id"], name: "index_mirrors_on_model_id", using: :btree

  create_table "model_colors", force: :cascade do |t|
    t.integer "model_id",          limit: 4
    t.integer "interior_color_id", limit: 4
    t.integer "exterior_color_id", limit: 4
  end

  add_index "model_colors", ["exterior_color_id"], name: "index_model_colors_on_exterior_color_id", using: :btree
  add_index "model_colors", ["interior_color_id"], name: "index_model_colors_on_interior_color_id", using: :btree
  add_index "model_colors", ["model_id"], name: "index_model_colors_on_model_id", using: :btree

  create_table "models", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "produce_year", limit: 255
    t.integer  "autohome_id",  limit: 4
    t.integer  "series_id",    limit: 4
    t.string   "structure",    limit: 255
    t.string   "displacement", limit: 255
    t.string   "gearbox_name", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "models", ["autohome_id"], name: "index_models_on_autohome_id", using: :btree
  add_index "models", ["displacement"], name: "index_models_on_displacement", using: :btree
  add_index "models", ["gearbox_name"], name: "index_models_on_gearbox_name", using: :btree
  add_index "models", ["produce_year"], name: "index_models_on_produce_year", using: :btree
  add_index "models", ["series_id"], name: "index_models_on_series_id", using: :btree
  add_index "models", ["structure"], name: "index_models_on_structure", using: :btree

  create_table "multimedia", force: :cascade do |t|
    t.integer  "model_id",          limit: 4
    t.string   "GPS",               limit: 255
    t.string   "LBS",               limit: 255
    t.string   "large_screen",      limit: 255
    t.string   "bluetooth",         limit: 255
    t.string   "TV",                limit: 255
    t.string   "rear_LED",          limit: 255
    t.string   "power",             limit: 255
    t.string   "AUX",               limit: 255
    t.string   "WMA",               limit: 255
    t.string   "meltimedia_system", limit: 255
    t.string   "speaker_brand",     limit: 255
    t.string   "speaker_num",       limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "multimedia", ["model_id"], name: "index_multimedia_on_model_id", using: :btree

  create_table "safeties", force: :cascade do |t|
    t.integer  "model_id",                limit: 4
    t.string   "driving_seet_airbag",     limit: 255
    t.string   "side_airbag",             limit: 255
    t.string   "head_airbag",             limit: 255
    t.string   "knee_airbag",             limit: 255
    t.string   "TPMS",                    limit: 255
    t.string   "zero",                    limit: 255
    t.string   "belt_warning",            limit: 255
    t.string   "ISOFIX",                  limit: 255
    t.string   "immobilizer",             limit: 255
    t.string   "internally_door_locking", limit: 255
    t.string   "key_fob",                 limit: 255
    t.string   "keyless_start",           limit: 255
    t.string   "keyless_entry",           limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "safeties", ["model_id"], name: "index_safeties_on_model_id", using: :btree

  create_table "seats", force: :cascade do |t|
    t.integer  "model_id",                    limit: 4
    t.string   "material",                    limit: 255
    t.string   "sport_sytle",                 limit: 255
    t.string   "height_adjustment",           limit: 255
    t.string   "lumbar_adjustment",           limit: 255
    t.string   "shoulder_adjustment",         limit: 255
    t.string   "electric_adjustment",         limit: 255
    t.string   "second_backrest_adjustment",  limit: 255
    t.string   "second_move",                 limit: 255
    t.string   "backrow_electric_adjustment", limit: 255
    t.string   "memory",                      limit: 255
    t.string   "heating",                     limit: 255
    t.string   "ventilation",                 limit: 255
    t.string   "massage",                     limit: 255
    t.string   "third_seat",                  limit: 255
    t.string   "rear_seat_down",              limit: 255
    t.string   "centre_armrest",              limit: 255
    t.string   "rear_cap_shelf",              limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "seats", ["model_id"], name: "index_seats_on_model_id", using: :btree

  create_table "series", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "first_letter", limit: 255
    t.integer  "autohome_id",  limit: 4
    t.integer  "factory_id",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "series", ["autohome_id"], name: "index_series_on_autohome_id", using: :btree
  add_index "series", ["factory_id"], name: "index_series_on_factory_id", using: :btree
  add_index "series", ["first_letter"], name: "index_series_on_first_letter", using: :btree

  create_table "steerings", force: :cascade do |t|
    t.integer  "model_id",              limit: 4
    t.string   "drivetrain",            limit: 255
    t.string   "front_suspension_type", limit: 255
    t.string   "rear_suspension_type",  limit: 255
    t.string   "power_type",            limit: 255
    t.string   "body_structure",        limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "steerings", ["model_id"], name: "index_steerings_on_model_id", using: :btree

  create_table "transmissions", force: :cascade do |t|
    t.integer  "model_id",   limit: 4
    t.string   "name",       limit: 255
    t.string   "trans_num",  limit: 255
    t.string   "trans_type", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "transmissions", ["model_id"], name: "index_transmissions_on_model_id", using: :btree

  create_table "vehicle_bodies", force: :cascade do |t|
    t.integer  "model_id",             limit: 4
    t.string   "length",               limit: 255
    t.string   "width",                limit: 255
    t.string   "height",               limit: 255
    t.string   "wheelbase",            limit: 255
    t.string   "front_track_width",    limit: 255
    t.string   "rear_track_width",     limit: 255
    t.string   "min_ground_clearance", limit: 255
    t.string   "curb_weight",          limit: 255
    t.string   "structure",            limit: 255
    t.string   "doors_num",            limit: 255
    t.string   "seats_num",            limit: 255
    t.string   "tank_capatity",        limit: 255
    t.string   "trunk_volume",         limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "vehicle_bodies", ["model_id"], name: "index_vehicle_bodies_on_model_id", using: :btree

end
