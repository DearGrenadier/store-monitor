class LineItem < ApplicationRecord
  belongs_to :product_attr
  belongs_to :order
end
