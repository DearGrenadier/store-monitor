class RemoveProductRefrenceFromLineItem < ActiveRecord::Migration[5.0]
  def change
    remove_column :line_items, :product_id
  end
end
