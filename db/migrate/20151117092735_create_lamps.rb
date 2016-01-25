class CreateLamps < ActiveRecord::Migration
  def change
    create_table :lamps do |t|
      t.belongs_to :model, index: true
      t.string :low_beam #近光灯
      t.string :high_beam #远光灯
      t.string :DRL #日间行车灯
      t.string :adaptive_distance_light #自适应远近光
      t.string :auto_headlamp #自动头灯
      t.string :cornering_lamp  #转向辅助灯
      t.string :cornering_headlamp  #转向头灯
      t.string :front_fog_lamp #前雾灯
      t.string :headling_adjustable #大灯高度可调
      t.string :SRA #大灯清洗装置
      t.string :ambient_lighting #车内氛围灯

      t.timestamps null: false
    end
  end
end
