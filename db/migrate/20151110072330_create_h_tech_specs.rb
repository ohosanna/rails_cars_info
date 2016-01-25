class CreateHTechSpecs < ActiveRecord::Migration
  def change
    create_table :h_tech_specs do |t|
      t.belongs_to :model, index: true
      t.string :auto_parking #自动泊车
      t.string :start_stop #发动机启停技术
      t.string :BLIS #并线辅助
      t.string :LDWS #车道偏离预警系统
      t.string :active_safety #主动刹车/主动安全系统
      t.string :active_dynamic_steering #整体主动转向系统
      t.string :night_vision #夜视系统
      t.string :splitview #中控液晶屏分屏显示
      t.string :ACC #自适应巡航
      t.string :pancam #全景摄像头

      t.timestamps null: false
    end
  end
end
