class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  accepts_nested_attributes_for :line_items, reject_if: proc { |attrs| attrs['quantity'].to_i.zero? }

  enum status: {not_confirmed: 0, confirmed: 1, declined: 2, pending: 3, done: 4}

  def calculate_total_price
    self.total_price = line_items.inject(0) { |mem, elem| mem + Product.find(elem.product_id).price * elem.quantity }
  end

end
