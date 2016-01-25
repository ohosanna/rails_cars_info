class CreateInteriorColors < ActiveRecord::Migration
  def change
    create_table :interior_colors do |t|
      t.integer :autohome_id, index: true
      t.string :name
      t.string :values
    end
  end
end
