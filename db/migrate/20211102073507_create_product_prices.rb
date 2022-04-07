class CreateProductPrices < ActiveRecord::Migration[6.1]
  def change
    create_table :product_prices do |t|
      t.string :name
      t.date :price_date
      t.string :buy_sell_segment
      t.integer :price

      t.timestamps
    end
  end
end
