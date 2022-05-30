class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name, null: false
      t.integer :price, null: false
      t.boolean :is_active, default: true
      t.text :description, null: false

      t.timestamps
    end
  end
end
