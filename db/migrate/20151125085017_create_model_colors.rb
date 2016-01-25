class CreateModelColors < ActiveRecord::Migration
  def change
    create_table :model_colors do |t|
      t.integer :model_id, index: true
      t.integer :interior_color_id, index: true
      t.integer :exterior_color_id, index: true
    end
  end
end
