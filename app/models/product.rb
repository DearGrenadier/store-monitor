class Product < ApplicationRecord
  has_many :product_attrs, -> { includes :size }
  has_many :sizes, through: :product_attrs

  accepts_nested_attributes_for :product_attrs, reject_if: :all_blank

  validates :name, uniqueness: true, presence: true
end
