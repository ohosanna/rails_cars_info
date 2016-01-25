class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.belongs_to :model, index: true
      t.string :material #座椅材质
      t.string :sport_sytle #运动风格座椅
      t.string :height_adjustment #座椅高低调节
      t.string :lumbar_adjustment #腰部支撑调节
      t.string :shoulder_adjustment #肩部支撑调节
      t.string :electric_adjustment #主/副驾驶座电动调节
      t.string :second_backrest_adjustment #第二排靠背角度调节
      t.string :second_move  #第二排靠背角度调节
      t.string :backrow_electric_adjustment #后排座椅电动调节
      t.string :memory #电动座椅记忆
      t.string :heating  #前/后排座椅加热
      t.string :ventilation #前/后排座椅通风
      t.string :massage #前/后排座椅按摩
      t.string :third_seat #第三排座椅
      t.string :rear_seat_down #后排座椅放倒方式
      t.string :centre_armrest #前/后中央扶手
      t.string :rear_cap_shelf #后排杯架

      t.timestamps null: false
    end
  end
end
