class AddReferencesBrandToProductPrice < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_prices, :brand, foreign_key: true
  end
end
