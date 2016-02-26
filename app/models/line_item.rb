class LineItem < ApplicationRecord
  belongs_to :product_attr
  belongs_to :order

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
