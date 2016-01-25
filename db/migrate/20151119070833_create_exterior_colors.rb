class CreateExteriorColors < ActiveRecord::Migration
  def change
    create_table :exterior_colors do |t|
      t.integer :autohome_id, index: true
      t.string :name
      t.string :value
    end
  end
end
