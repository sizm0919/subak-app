class RemoveNameFromProductPrice < ActiveRecord::Migration[6.1]
  def change
    remove_column :product_prices, :name, :string
  end
end
