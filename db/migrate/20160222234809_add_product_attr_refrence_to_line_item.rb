class AddProductAttrRefrenceToLineItem < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :product_attr_id, :integer
    add_index :line_items, :product_attr_id
  end
end
