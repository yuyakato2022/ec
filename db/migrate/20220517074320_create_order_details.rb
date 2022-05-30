class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :production_status
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
