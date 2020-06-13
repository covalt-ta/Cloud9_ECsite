# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
         
  has_one :basket, dependent: :destroy
  has_one :purchase_record, dependent: :destroy
  has_many :purchase_record_products, through: :purchase_record
  
  include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
  def prepare_basket
    basket || create_basket
  end

  def prepare_purchase_record
    purchase_record || create_purchase_record
  end

  def checkout!(token, product_ids:)
    total = basket.total_price(product_ids: product_ids)
    transaction do
      basket_products = basket.basket_products.where(product_id: product_ids)
      basket_products.each(&:destroy!)
      
      purchase_record = prepare_purchase_record
      ids = product_ids.map{ |id| { product_id: id } }
      purchase_record.purchase_record_products.create!(ids)
    end
    Charge.create!(total, token)
  end
end
