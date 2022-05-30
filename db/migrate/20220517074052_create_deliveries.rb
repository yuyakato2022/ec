class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.integer :customer_id
      t.string :address_name, null: false
      t.string :postcode, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
