class CreateMultimedia < ActiveRecord::Migration
  def change
    create_table :multimedia do |t|
      t.belongs_to :model, index: true
      t.string :GPS #GPS 导航系统
      t.string :LBS #定位互动服务
      t.string :large_screen #中控台彩色大屏
      t.string :bluetooth #蓝牙/车载电话
      t.string :TV #车载电视
      t.string :rear_LED #后排液晶屏
      t.string :power #220V/230V电源
      t.string :AUX #外接音源接口
      t.string :WMA  #CD 支持 MP3/WMA
      t.string :meltimedia_system #多媒体系统
      t.string :speaker_brand #扬声器品牌
      t.string :speaker_num #扬声器数量

      t.timestamps null: false
    end
  end
end
