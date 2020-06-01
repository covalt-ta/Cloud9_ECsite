class PurchaseRecord < ApplicationRecord
    belongs_to :user
    has_many :purchase_record_products, dependent: :destroy
    has_many :products, through: :purchase_record_products
end
