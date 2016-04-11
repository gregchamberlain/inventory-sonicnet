class CreateItemStocks < ActiveRecord::Migration
  def change
    create_table :item_stocks do |t|
      t.integer :item_id
      t.integer :location_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
