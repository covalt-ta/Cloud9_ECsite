class Basket < ApplicationRecord
  has_many :basket_products, dependent: :destroy
  has_many :products, through: :basket_products
  
  def total_price(product_ids: nil)
    products = product_ids ? self.products.where(id: product_ids) : self.products
    PriceCalculator.total(products)
  end
end