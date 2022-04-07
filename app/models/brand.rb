class Brand < ApplicationRecord
    has_many :product, dependent: :destroy
    has_many :product_price, dependent: :destroy
    has_many :cattle_num, dependent: :destroy
end
