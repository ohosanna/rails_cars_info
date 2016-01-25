class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.integer :autohome_id
      t.string :first_letter

      t.timestamps null: false
    end
    add_index :brands, :autohome_id
    add_index :brands, :first_letter
  end
end
