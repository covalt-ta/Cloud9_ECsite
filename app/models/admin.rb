class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_many :purchase_record_products, through: :products
  
  def sales
    sold_products = self.products.joins(:purchase_record_products)
    PriceCalculator.total(sold_products)
  end
  
  def sales_this_manth
    sold_products = self.products.joins(:purchase_record_products).where({ purchase_record_products: {created_at: Time.current.all_month} })
    PriceCalculator.total(sold_products)
  end
  
end
