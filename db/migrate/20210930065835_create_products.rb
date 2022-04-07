class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.text :callput
      t.text :brand
      t.date :settlement_date
      t.date :closing_date
      t.integer :exercise_price
      t.integer :option_premium

      t.timestamps
    end
  end
end
