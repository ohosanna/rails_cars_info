class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name
      t.string :produce_year
      t.integer :autohome_id
      t.integer :series_id
      #配合VIN数据搜索字段
      t.string :structure
      t.string :displacement
      t.string :gearbox_name

      t.timestamps null: false
    end
    add_index :models, :autohome_id
    add_index :models, :series_id
    add_index :models, :produce_year
    add_index :models, :structure
    add_index :models, :displacement
    add_index :models, :gearbox_name
  end
end
