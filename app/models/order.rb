class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :delete_all
  has_many :products, through: :line_items

  accepts_nested_attributes_for :line_items, reject_if: proc { |attrs| attrs['quantity'].to_i.zero? }

  enum status: [:not_confirmed, :confirmed, :declined, :pending, :done]

  after_update :check_if_decline

  validates :status, presence: true

  STATUSES = [['Подтвержден', :confirmed], ['В обработке', :pending], ['Отклонен', :declined], ['Выполнен', :done]]

  def calculate_total_price
    self.total_price = line_items.inject(0) { |mem, elem| mem + elem.product_attr.price * elem.quantity }
  end

  def check_amounts
    line_items.each do |l_i|
      return false if l_i.quantity > l_i.product_attr.amount
    end
    true
  end

  def translate_status
    case status
    when 'confirmed'
      'Подтвержден'
    when 'pending'
      'В обработке'
    when 'done'
      'Выполнен'
    when 'declined'
      'Откланен'
    when 'not_confirmed'
      'Не подтвержден'
    end
  end

  private

  def check_if_decline
    if status == "declined"
      line_items.each do |l_i|
        current_amount = l_i.product_attr.amount
        new_amount = current_amount + l_i.quantity
        l_i.product_attr.update!(amount: new_amount)
      end
    end
  end
end
