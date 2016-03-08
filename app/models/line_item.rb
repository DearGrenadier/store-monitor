class LineItem < ApplicationRecord
  belongs_to :product_attr
  belongs_to :order

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  after_destroy :free_products

  private

  def free_products
    current_amount = product_attr.amount
    new_amount = current_amount + quantity
    product_attr.update!(amount: new_amount)
  end
end
