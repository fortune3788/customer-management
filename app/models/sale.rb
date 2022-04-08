class Sale < ApplicationRecord
  belongs_to :client
  
  validates :date, presence: true
  validates :item, presence: true, length: { maximum: 50 }
  validates :item_quantity, presence: true
end
