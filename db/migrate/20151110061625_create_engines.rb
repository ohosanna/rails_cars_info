class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.belongs_to :model, index: true
      t.string :name #型号
      t.string :displacement #排量
      t.string :intake_type #进气形式
      t.string :cylinder_arrangement #气缸排列形式
      t.string :cylinder_num #气缸数
      t.string :valve_num #每气缸气门数
      t.string :compression_ratio #压缩比
      t.string :valve_train #配气机构
      t.string :cylinder_bore #缸径
      t.string :piston_stroke #活塞行程
      t.string :max_hp #最大马力
      t.string :max_power #最大功率
      t.string :max_power_speed #最大功率转速
      t.string :max_torque #最大扭距
      t.string :max_torque_speed #最大扭距转速
      t.string :unique_tech #特有技术
      t.string :fuel_type #燃油形式
      t.string :fuel_grade #燃油标号
      t.string :oil_supply #供油方式
      t.string :cylinder_head_material #缸盖材料
      t.string :cylinder_block_material #缸体材料
      t.string :EPA #环保标准

      t.timestamps null: false
    end
  end
end
