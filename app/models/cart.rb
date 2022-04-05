class Cart < ApplicationRecord
    has_many :cart_item, dependent: :destroy
    belongs_to :account , optional: true
end
