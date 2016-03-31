require 'csv'

class ProductsCSVBuilder
  HEADER = %w( Наименование Размер Цена(руб.) Количество )

  def self.build 
    CSV.generate do |csv|
      csv << HEADER
      Product.all.each do |product|
        product.product_attrs.map.with_index do |product_attr, index|
          first_column = index.zero? ? product.name : nil
          csv << [first_column, product_attr.size.value, product_attr.price, product_attr.amount]
        end
      end
    end
  end
end
