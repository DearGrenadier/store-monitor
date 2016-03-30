class DeletePriceAndQuantityFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :quantity
    remove_column :products, :price
  end
end
