class CreateExteriors < ActiveRecord::Migration
  def change
    create_table :exteriors do |t|
      t.belongs_to :model, index: true
      t.string :power_sunroof #电动天窗
      t.string :panoramic_sunroof #全景天窗
      t.string :sport_appearance #运动外观套件
      t.string :allowy_wheel #铝合金轮圈
      t.string :electric_suction_door #电动吸合门
      t.string :sliding_door #侧滑门
      t.string :electric_trunk #电动后备厢
      t.string :sensing_trunk #感应后备厢
      t.string :roof_rack #车顶行李架

      t.timestamps null: false
    end
  end
end
