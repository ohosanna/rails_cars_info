class CreateInteriors < ActiveRecord::Migration
  def change
    create_table :interiors do |t|
      t.belongs_to :model, index: true
      t.string :leather_steering #真皮方向盘
      t.string :steering_adjestment #方向盘调节
      t.string :steering_electric_adjestment #方向盘电动调节
      t.string :MFL  #多功能方向盘
      t.string :paddle_shift #方向盘换档
      t.string :LHZ #方向盘加热
      t.string :steering_memory #方向盘记忆
      t.string :CCS #定速巡航
      t.string :parking_radar #驻车雷达
      t.string :CCD #倒车视频影像
      t.string :ECU_display #行车电脑显示屏
      t.string :LED_dashboard #全液晶仪表盘
      t.string :HUD #HUD抬头数字显示

      t.timestamps null: false
    end
  end
end
