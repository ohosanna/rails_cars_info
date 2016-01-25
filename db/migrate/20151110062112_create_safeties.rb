class CreateSafeties < ActiveRecord::Migration
  def change
    create_table :safeties do |t|
      t.belongs_to :model, index: true
      t.string :driving_seet_airbag #主/副驾驶座安全气囊
      t.string :side_airbag #前/后排侧气囊
      t.string :head_airbag #前/后排头部气囊
      t.string :knee_airbag #膝部气囊
      t.string :TPMS #胎压监测装置
      t.string :zero #零胎压继续行驶
      t.string :belt_warning #安全带未系提示
      t.string :ISOFIX #ISOFIX 儿童座椅接口
      t.string :immobilizer #发动机电子防盗
      t.string :internally_door_locking #车内中控锁
      t.string :key_fob #遥控钥匙
      t.string :keyless_start #无钥匙启动系统
      t.string :keyless_entry #无钥匙进入系统

      t.timestamps null: false
    end
  end
end
