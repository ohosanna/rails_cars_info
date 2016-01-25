class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :name
      t.string :first_letter
      t.integer :autohome_id
      t.integer :factory_id

      t.timestamps null: false
    end
    add_index :series, :autohome_id
    add_index :series, :first_letter
    add_index :series, :factory_id
  end
end
