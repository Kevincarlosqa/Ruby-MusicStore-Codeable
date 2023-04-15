class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :album
  validates :quantity, numericality: { greater_than: 0 }
end
