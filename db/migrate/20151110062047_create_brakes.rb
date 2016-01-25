class CreateBrakes < ActiveRecord::Migration
  def change
    create_table :brakes do |t|
      t.belongs_to :model, index: true
      t.string :front_brake_type #前制动器类型
      t.string :rear_brake_type #后制动器类型
      t.string :parking_brake_type #驻车制动器类型
      t.string :front_tire_size #前轮胎规格
      t.string :rear_tire_size #后轮胎规格
      t.string :spare_tire_size #备胎规格

      t.timestamps null: false
    end
  end
end
