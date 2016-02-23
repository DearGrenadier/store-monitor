class Product < ApplicationRecord
  has_many :product_attrs
  has_many :sizes, through: :product_attrs

  accepts_nested_attributes_for :product_attrs

  validates :name, uniqueness: true, presence: true
end
