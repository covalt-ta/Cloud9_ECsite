class Basket < ApplicationRecord
    has_many :basket_products, dependent: :destroy
    has_many :products, through: :basket_products
end