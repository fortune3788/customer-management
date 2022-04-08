class Client < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  
  has_many :sales, dependent: :destroy
end
