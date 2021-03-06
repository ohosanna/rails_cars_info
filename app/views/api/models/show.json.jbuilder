if @model.nil?
  json.error_code "404"
  json.error_msg "未找到该id车型的信息"
else
  json.model do
    json.id @model.id
    json.name @model.name
    json.base_spec @model.base_spec
    json.vehicle_body @model.vehicle_body
    json.engine @model.engine
    # json.engine do
    #   json.name @model.engine.name
    #   json.intake_type @model.engine.intake_type
    #   json.max_hp @model.engine.max_hp
    #   json.max_power @model.engine.max_power
    #   json.max_power_speed @model.engine.max_power_speed
    #   json.max_torque @model.engine.max_torque
    #   json.max_torque_speed @model.engine.max_torque_speed
    #   json.oil_supply @model.engine.oil_supply
    #   json.EPA @model.engine.EPA
    #   json.displacement @model.engine.displacement
    #   json.cylinder_arrangement @model.engine.cylinder_arrangement
    #   json.cylinder_num @model.engine.cylinder_num
    #   json.valve_num @model.engine.valve_num
    #   json.valve_train @model.engine.valve_train
    #   json.compression_ratio @model.engine.compression_ratio
    #   json.cylinder_bore @model.engine.cylinder_bore
    #   json.cylinder_head_material @model.engine.cylinder_head_material
    #   json.cylinder_block_material @model.engine.cylinder_block_material
    #   json.fuel_type  @model.engine.fuel_type
    #   json.fuel_grade  @model.engine.fuel_grade
    #   json.piston_stroke  @model.engine.piston_stroke
    # end
    json.transmission @model.transmission
    json.brake @model.brake
    json.console @model.console
    json.lamp @model.lamp
    json.mirror @model.mirror
    json.multimedium @model.multimedium
    json.safety @model.safety
    json.seat @model.seat
  end
end
