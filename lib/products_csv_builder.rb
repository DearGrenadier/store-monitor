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
          row = index.zero? ? [product.name] : [nil]
          row << product_attr.size.value << number_to_currency(product_attr.price, delimiter: ' ',
                                                               precision: 0, format: '%n') << product_attr.amount
          csv << row
        end
      end
    end
  end
end
