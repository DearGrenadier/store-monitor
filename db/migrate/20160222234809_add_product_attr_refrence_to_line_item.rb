class AddProductAttrRefrenceToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :product_attr_id, :integer
    add_index :line_items, :product_attr_id
  end
end
