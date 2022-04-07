class RemoveBuySellSegmentFromProductPrice < ActiveRecord::Migration[6.1]
  def change
    remove_column :product_prices, :buy_sell_segment, :string
  end
end
