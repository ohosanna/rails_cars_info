class CreateMirrors < ActiveRecord::Migration
  def change
    create_table :mirrors do |t|
      t.belongs_to :model, index: true
      t.string :power_window #前/后电动车窗
      t.string :anti_pinch #车窗防夹手功能
      t.string :insulating_glass #防紫外线/隔热玻璃
      t.string :power_adjustable #后视镜电动调节
      t.string :heated  #后视镜加热
      t.string :anti_dazzling #内/外后视镜防眩目
      t.string :electrically_folding #后视镜电动折叠
      t.string :memory #后视镜记忆
      t.string :rear_windshield_sunshade #后风档遮阳帘
      t.string :rear_side_sunshade #后排侧遮阳帘
      t.string :rear_privacy_glass  #后排侧隐私玻璃
      t.string :sun_visor  #遮阳板化妆镜
      t.string :rear_wiper #后雨刷
      t.string :sensing_wiper #感应雨刷

      t.timestamps null: false
    end
  end
end
