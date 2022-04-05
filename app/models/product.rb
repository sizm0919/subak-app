class Product < ApplicationRecord
    has_one :order, dependent: :destroy
    belongs_to :brand
end
