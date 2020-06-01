class PurchaseRecordProduct < ApplicationRecord
    belongs_to :purchase_record
    belongs_to :product
end
