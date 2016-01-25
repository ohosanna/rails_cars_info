class CreateFactories < ActiveRecord::Migration
  def change
    create_table :factories do |t|
      t.string :name
      t.string :first_letter
      t.integer :autohome_id
      t.integer :brand_id

      t.timestamps null: false
    end
    add_index :factories, :autohome_id
    add_index :factories, :first_letter
    add_index :factories, :brand_id
  end
end
