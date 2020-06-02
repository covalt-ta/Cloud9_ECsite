# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  price       :integer          not null
#  unit        :string           default("yen"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
    validates :price, presence: true
    validates :unit, presence: true
    USD_RATE = 110.freeze
    
    extend Enumerize
    enumerize :unit, in:[:yen, :usd]
    mount_uploader :image, ImageUploader
    include Hashid::Rails
    has_many :basket_products, dependent: :destroy
    has_many :purchase_products, dependent: :destroy
    belongs_to :admin
end
