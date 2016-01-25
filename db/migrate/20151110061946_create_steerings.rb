class CreateSteerings < ActiveRecord::Migration
  def change
    create_table :steerings do |t|
      t.belongs_to :model, index: true
      t.string :drivetrain #驱动方式
      t.string :front_suspension_type #前悬挂类型
      t.string :rear_suspension_type #后悬挂类型
      t.string :power_type #助力类型
      t.string :body_structure #车体结构

      t.timestamps null: false
    end
  end
end
