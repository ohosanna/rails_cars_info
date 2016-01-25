class CreateTransmissions < ActiveRecord::Migration
  def change
    create_table :transmissions do |t|
      t.belongs_to :model, index: true
      t.string :name #简称
      t.string :trans_num #档位个数
      t.string :trans_type #类型

      t.timestamps null: false
    end
  end
end
