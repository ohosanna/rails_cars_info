class CreateVehicleBodies < ActiveRecord::Migration
  def change
    create_table :vehicle_bodies do |t|
      t.belongs_to :model, index: true
      t.string :length #长
      t.string :width #宽
      t.string :height #高
      t.string :wheelbase #轴距
      t.string :front_track_width #前轮距
      t.string :rear_track_width #后轮距
      t.string :min_ground_clearance #最小离地间隙
      t.string :curb_weight #整备质量
      t.string :structure #车身结构
      t.string :doors_num #车门个数
      t.string :seats_num #座位个数
      t.string :tank_capatity #油箱容量
      t.string :trunk_volume #行李箱容积

      t.timestamps null: false
    end
  end
end
