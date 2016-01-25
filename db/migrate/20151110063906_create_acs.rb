class CreateAcs < ActiveRecord::Migration
  def change
    create_table :acs do |t|
      t.belongs_to :model, index: true
      t.string :control_mode #控制方式
      t.string :rear_control #后排独立空调
      t.string :rear_air_outlet #后排出风口
      t.string :temperature_zoning #温度分区控制
      t.string :pollen_filter #车内空气调节/花粉过滤
      t.string :cooler #车载冰箱

      t.timestamps null: false
    end
  end
end
