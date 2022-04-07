class CreateCattleNums < ActiveRecord::Migration[6.1]
  def change
    create_table :cattle_nums do |t|
      t.references :brand, null: false, foreign_key: true
      t.date :date
      t.integer :num

      t.timestamps
    end
  end
end
