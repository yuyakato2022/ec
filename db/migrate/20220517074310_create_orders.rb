class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :pay_way, null: false
      t.integer :postage, null: false
      t.integer :status, default: 0
      t.string :postcode, null: false
      t.string :address, null: false
      t.string :address_name, null: false
      t.integer :total_pay, null: false

      t.timestamps
    end
  end
end
