class Size < ApplicationRecord
  has_many :product_attrs
  has_many :products, through: :product_attrs
end
