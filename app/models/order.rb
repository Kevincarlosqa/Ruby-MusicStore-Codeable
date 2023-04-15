class Order < ApplicationRecord
  belongs_to :customer
  validates :total, numericality: { greater_than: 0 }
  validates :date, comparison: { less_than: Time.zone.today,
                                                                    messages: "can't be in the future" }
end
