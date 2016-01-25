class CreateBaseSpecs < ActiveRecord::Migration
  def change
    create_table :base_specs do |t|
      t.belongs_to :model, index: true
      t.string :name #车型名称
      t.string :price #厂商指导价
      t.string :factory #厂商
      t.string :level #级别
      t.string :engine #发动机
      t.string :gearbox #变速箱
      t.string :LWH #长宽高
      t.string :body_structure #车身结构
      t.string :max_speed #最高车速
      t.string :acceleration_time #百公里加速
      t.string :real_acceleration_time #实测百公里加速
      t.string :braking_time #百时速制动时间
      t.string :fuel_consumption #百公里油耗
      t.string :real_fuel_consumption #实际百公里油耗
      t.string :real_ground_clearance #实际离地间隙
      t.string :warranty #质保

      t.timestamps null: false
    end
  end
end
