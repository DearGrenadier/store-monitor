class Product < ApplicationRecord
  has_many :product_attrs
  has_many :sizes, through: :product_attrs
end
