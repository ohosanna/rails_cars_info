class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name
      t.string :produce_year
      t.integer :autohome_id
      t.integer :series_id

      t.timestamps null: false
    end
    add_index :models, :autohome_id
    add_index :models, :series_id
    add_index :models, :produce_year
  end
end
