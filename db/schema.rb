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

  create_table "acs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "control_mode"
    t.string   "rear_control"
    t.string   "rear_air_outlet"
    t.string   "temperature_zoning"
    t.string   "pollen_filter"
    t.string   "cooler"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["model_id"], name: "index_acs_on_model_id", using: :btree
  end

  create_table "base_specs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "name"
    t.string   "price"
    t.string   "factory"
    t.string   "level"
    t.string   "engine"
    t.string   "gearbox"
    t.string   "LWH"
    t.string   "body_structure"
    t.string   "max_speed"
    t.string   "acceleration_time"
    t.string   "real_acceleration_time"
    t.string   "braking_time"
    t.string   "fuel_consumption"
    t.string   "real_fuel_consumption"
    t.string   "real_ground_clearance"
    t.string   "warranty"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["model_id"], name: "index_base_specs_on_model_id", using: :btree
  end

  create_table "brakes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "front_brake_type"
    t.string   "rear_brake_type"
    t.string   "parking_brake_type"
    t.string   "front_tire_size"
    t.string   "rear_tire_size"
    t.string   "spare_tire_size"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["model_id"], name: "index_brakes_on_model_id", using: :btree
  end

  create_table "brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "autohome_id"
    t.string   "first_letter"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["autohome_id"], name: "index_brands_on_autohome_id", using: :btree
    t.index ["first_letter"], name: "index_brands_on_first_letter", using: :btree
  end

  create_table "consoles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "ABS"
    t.string   "EBD"
    t.string   "EBA"
    t.string   "ASR"
    t.string   "ESC"
    t.string   "HAC"
    t.string   "auto_hold"
    t.string   "HDC"
    t.string   "variable_suspension"
    t.string   "air_suspension"
    t.string   "variable_gear_ratio"
    t.string   "f_XDS"
    t.string   "central_diff_lock"
    t.string   "b_XDS"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["model_id"], name: "index_consoles_on_model_id", using: :btree
  end

  create_table "engines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "name"
    t.string   "displacement"
    t.string   "intake_type"
    t.string   "cylinder_arrangement"
    t.string   "cylinder_num"
    t.string   "valve_num"
    t.string   "compression_ratio"
    t.string   "valve_train"
    t.string   "cylinder_bore"
    t.string   "piston_stroke"
    t.string   "max_hp"
    t.string   "max_power"
    t.string   "max_power_speed"
    t.string   "max_torque"
    t.string   "max_torque_speed"
    t.string   "unique_tech"
    t.string   "fuel_type"
    t.string   "fuel_grade"
    t.string   "oil_supply"
    t.string   "cylinder_head_material"
    t.string   "cylinder_block_material"
    t.string   "EPA"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["model_id"], name: "index_engines_on_model_id", using: :btree
  end

  create_table "exterior_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "autohome_id"
    t.string  "name"
    t.string  "value"
    t.index ["autohome_id"], name: "index_exterior_colors_on_autohome_id", using: :btree
  end

  create_table "exteriors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "power_sunroof"
    t.string   "panoramic_sunroof"
    t.string   "sport_appearance"
    t.string   "allowy_wheel"
    t.string   "electric_suction_door"
    t.string   "sliding_door"
    t.string   "electric_trunk"
    t.string   "sensing_trunk"
    t.string   "roof_rack"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["model_id"], name: "index_exteriors_on_model_id", using: :btree
  end

  create_table "factories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "first_letter"
    t.integer  "autohome_id"
    t.integer  "brand_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["autohome_id"], name: "index_factories_on_autohome_id", using: :btree
    t.index ["brand_id"], name: "index_factories_on_brand_id", using: :btree
    t.index ["first_letter"], name: "index_factories_on_first_letter", using: :btree
  end

  create_table "h_tech_specs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "auto_parking"
    t.string   "start_stop"
    t.string   "BLIS"
    t.string   "LDWS"
    t.string   "active_safety"
    t.string   "active_dynamic_steering"
    t.string   "night_vision"
    t.string   "splitview"
    t.string   "ACC"
    t.string   "pancam"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["model_id"], name: "index_h_tech_specs_on_model_id", using: :btree
  end

  create_table "interior_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "autohome_id"
    t.string  "name"
    t.string  "values"
    t.index ["autohome_id"], name: "index_interior_colors_on_autohome_id", using: :btree
  end

  create_table "interiors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "leather_steering"
    t.string   "steering_adjestment"
    t.string   "steering_electric_adjestment"
    t.string   "MFL"
    t.string   "paddle_shift"
    t.string   "LHZ"
    t.string   "steering_memory"
    t.string   "CCS"
    t.string   "parking_radar"
    t.string   "CCD"
    t.string   "ECU_display"
    t.string   "LED_dashboard"
    t.string   "HUD"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["model_id"], name: "index_interiors_on_model_id", using: :btree
  end

  create_table "lamps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "low_beam"
    t.string   "high_beam"
    t.string   "DRL"
    t.string   "adaptive_distance_light"
    t.string   "auto_headlamp"
    t.string   "cornering_lamp"
    t.string   "cornering_headlamp"
    t.string   "front_fog_lamp"
    t.string   "headling_adjustable"
    t.string   "SRA"
    t.string   "ambient_lighting"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["model_id"], name: "index_lamps_on_model_id", using: :btree
  end

  create_table "mirrors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "power_window"
    t.string   "anti_pinch"
    t.string   "insulating_glass"
    t.string   "power_adjustable"
    t.string   "heated"
    t.string   "anti_dazzling"
    t.string   "electrically_folding"
    t.string   "memory"
    t.string   "rear_windshield_sunshade"
    t.string   "rear_side_sunshade"
    t.string   "rear_privacy_glass"
    t.string   "sun_visor"
    t.string   "rear_wiper"
    t.string   "sensing_wiper"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["model_id"], name: "index_mirrors_on_model_id", using: :btree
  end

  create_table "model_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "model_id"
    t.integer "interior_color_id"
    t.integer "exterior_color_id"
    t.index ["exterior_color_id"], name: "index_model_colors_on_exterior_color_id", using: :btree
    t.index ["interior_color_id"], name: "index_model_colors_on_interior_color_id", using: :btree
    t.index ["model_id"], name: "index_model_colors_on_model_id", using: :btree
  end

  create_table "models", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "produce_year"
    t.integer  "autohome_id"
    t.integer  "series_id"
    t.string   "structure"
    t.string   "displacement"
    t.string   "gearbox_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["autohome_id"], name: "index_models_on_autohome_id", using: :btree
    t.index ["displacement"], name: "index_models_on_displacement", using: :btree
    t.index ["gearbox_name"], name: "index_models_on_gearbox_name", using: :btree
    t.index ["produce_year"], name: "index_models_on_produce_year", using: :btree
    t.index ["series_id"], name: "index_models_on_series_id", using: :btree
    t.index ["structure"], name: "index_models_on_structure", using: :btree
  end

  create_table "multimedia", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "GPS"
    t.string   "LBS"
    t.string   "large_screen"
    t.string   "bluetooth"
    t.string   "TV"
    t.string   "rear_LED"
    t.string   "power"
    t.string   "AUX"
    t.string   "WMA"
    t.string   "meltimedia_system"
    t.string   "speaker_brand"
    t.string   "speaker_num"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["model_id"], name: "index_multimedia_on_model_id", using: :btree
  end

  create_table "safeties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "driving_seet_airbag"
    t.string   "side_airbag"
    t.string   "head_airbag"
    t.string   "knee_airbag"
    t.string   "TPMS"
    t.string   "zero"
    t.string   "belt_warning"
    t.string   "ISOFIX"
    t.string   "immobilizer"
    t.string   "internally_door_locking"
    t.string   "key_fob"
    t.string   "keyless_start"
    t.string   "keyless_entry"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["model_id"], name: "index_safeties_on_model_id", using: :btree
  end

  create_table "seats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "material"
    t.string   "sport_sytle"
    t.string   "height_adjustment"
    t.string   "lumbar_adjustment"
    t.string   "shoulder_adjustment"
    t.string   "electric_adjustment"
    t.string   "second_backrest_adjustment"
    t.string   "second_move"
    t.string   "backrow_electric_adjustment"
    t.string   "memory"
    t.string   "heating"
    t.string   "ventilation"
    t.string   "massage"
    t.string   "third_seat"
    t.string   "rear_seat_down"
    t.string   "centre_armrest"
    t.string   "rear_cap_shelf"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["model_id"], name: "index_seats_on_model_id", using: :btree
  end

  create_table "series", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "first_letter"
    t.integer  "autohome_id"
    t.integer  "factory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["autohome_id"], name: "index_series_on_autohome_id", using: :btree
    t.index ["factory_id"], name: "index_series_on_factory_id", using: :btree
    t.index ["first_letter"], name: "index_series_on_first_letter", using: :btree
  end

  create_table "steerings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "drivetrain"
    t.string   "front_suspension_type"
    t.string   "rear_suspension_type"
    t.string   "power_type"
    t.string   "body_structure"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["model_id"], name: "index_steerings_on_model_id", using: :btree
  end

  create_table "transmissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "name"
    t.string   "trans_num"
    t.string   "trans_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_transmissions_on_model_id", using: :btree
  end

  create_table "vehicle_bodies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "model_id"
    t.string   "length"
    t.string   "width"
    t.string   "height"
    t.string   "wheelbase"
    t.string   "front_track_width"
    t.string   "rear_track_width"
    t.string   "min_ground_clearance"
    t.string   "curb_weight"
    t.string   "structure"
    t.string   "doors_num"
    t.string   "seats_num"
    t.string   "tank_capatity"
    t.string   "trunk_volume"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["model_id"], name: "index_vehicle_bodies_on_model_id", using: :btree
  end

end
