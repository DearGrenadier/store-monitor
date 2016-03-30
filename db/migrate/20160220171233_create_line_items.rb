class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :product
      t.belongs_to :order
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
