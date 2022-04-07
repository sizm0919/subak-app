class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  # カート内の商品合計に利用
  def sum_of_price
    product.option_premium * quantity
  end

end
