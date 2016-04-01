require 'csv'
require 'action_view'

class ProductsCSVBuilder
  extend ActionView::Helpers::NumberHelper

  HEADER = %w( Наименование Размер Цена(руб.) Количество )

  def self.build 
    CSV.generate do |csv|
      csv << HEADER
      Product.all.each do |product|
        product.product_attrs.map.with_index do |product_attr, index|
          first_column = index.zero? ? product.name : nil
          csv << [first_column, product_attr.size.value, format_price(product_attr.price), product_attr.amount]
        end
      end
    end
  end

  def self.format_price(price)
    number_to_currency(price, delimiter: ' ', precision: 0, format: '%n')
  end
end
