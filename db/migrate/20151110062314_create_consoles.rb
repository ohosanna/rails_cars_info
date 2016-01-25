class CreateConsoles < ActiveRecord::Migration
  def change
    create_table :consoles do |t|
      t.belongs_to :model, index: true
      t.string :ABS  #ABS防抱死
      t.string :EBD  #制动力分配（EBD/CBC等）
      t.string :EBA  #刹车辅助（EBA/BAS/BA等）
      t.string :ASR  #牵引力控制（ASR/TCS/TRC等）
      t.string :ESC  #车身稳定控制（ESC/ESP/DSC等）
      t.string :HAC  #上坡辅助
      t.string :auto_hold #自动驻车
      t.string :HDC #陡坡缓降
      t.string :variable_suspension #可变悬架
      t.string :air_suspension #空气悬架
      t.string :variable_gear_ratio #可变转向比
      t.string :f_XDS #前桥限滑差速器/差速锁
      t.string :central_diff_lock #中央差速器锁定功能
      t.string :b_XDS #后桥限滑差速器/差速锁

      t.timestamps null: false
    end
  end
end
