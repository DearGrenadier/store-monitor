class CreateProductAttrs < ActiveRecord::Migration[5.0]
  def change
    create_table :product_attrs do |t|
      t.belongs_to :size
      t.belongs_to :product
      t.integer :amount
      t.integer :price
      t.timestamps
    end
  end
end
